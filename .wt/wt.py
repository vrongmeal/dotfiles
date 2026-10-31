#!/usr/bin/env python3
"""wt: git worktree helper.

Convention: every worktree lives at <main checkout>/.worktrees/<branch>.
All commands work from anywhere in the repo, including inside a worktree.

A program can't change its parent shell's directory, so `cd` is handled by
the `wt` shell function in wt.sh: this script writes the target directory to
the file named in $WT_CD_FILE and the shell function cds there afterwards.
"""

from __future__ import annotations  # allows `X | None` hints on Python < 3.10

import argparse
import os
import subprocess
import sys
from pathlib import Path

WT_DIR = ".worktrees"


def die(msg: str, code: int = 1) -> None:
    print(f"wt: {msg}", file=sys.stderr)
    sys.exit(code)


def git(*args: str, cwd: Path | None = None) -> None:
    """Run a git command, letting its output through; exit on failure."""
    rc = subprocess.run(["git", *args], cwd=cwd).returncode
    if rc != 0:
        sys.exit(rc)


def git_ok(*args: str) -> bool:
    """Run a git command quietly; return whether it succeeded."""
    return subprocess.run(["git", *args], capture_output=True).returncode == 0


def git_out(*args: str) -> str:
    return subprocess.run(["git", *args], capture_output=True, text=True).stdout


def main_root() -> Path:
    """Path of the main checkout, from anywhere in the repo or its worktrees."""
    r = subprocess.run(
        ["git", "rev-parse", "--path-format=absolute", "--git-common-dir"],
        capture_output=True, text=True,
    )
    if r.returncode != 0:
        die("not inside a git repository")
    return Path(r.stdout.strip()).parent


def worktree_dir(root: Path, branch: str) -> Path:
    return root / WT_DIR / branch


def local_branch_exists(branch: str) -> bool:
    return git_ok("show-ref", "--verify", "--quiet", f"refs/heads/{branch}")


def remote_branch_exists(branch: str) -> bool:
    # strip=3 turns refs/remotes/<remote>/<name> into <name>, slashes included
    names = git_out("for-each-ref", "--format=%(refname:strip=3)", "refs/remotes")
    return branch in names.splitlines()


def request_cd(path: Path) -> None:
    target = os.environ.get("WT_CD_FILE")
    if target:
        Path(target).write_text(str(path))
    else:
        print(f"wt: (not run via the shell function) cd {path}", file=sys.stderr)


def cmd_add(args: argparse.Namespace) -> None:
    branch = args.branch
    if not git_ok("check-ref-format", "--branch", branch):
        die(f"'{branch}' is not a valid branch name")

    root = main_root()
    path = worktree_dir(root, branch)
    if path.exists():
        die(f"{path} already exists (use: wt cd {branch})")

    exists = local_branch_exists(branch) or remote_branch_exists(branch)
    if args.create:
        if exists:
            die(f"branch '{branch}' already exists; drop -c to check it out")
        # HEAD here is the current worktree's HEAD, i.e. "where I am now"
        git("worktree", "add", "-b", branch, str(path), "HEAD")
    else:
        if not exists:
            die(f"no branch '{branch}'; use -c to create it from HEAD")
        # For a remote-only branch git creates a local tracking branch
        git("worktree", "add", str(path), branch)

    if args.go:
        request_cd(path)


def cmd_cd(args: argparse.Namespace) -> None:
    root = main_root()
    if not args.branch:
        request_cd(root)
        return
    path = worktree_dir(root, args.branch)
    if not path.is_dir():
        die(f"no worktree for '{args.branch}' (use: wt add {args.branch})")
    request_cd(path)


def cmd_rm(args: argparse.Namespace) -> None:
    root = main_root()
    path = worktree_dir(root, args.branch)
    if not path.is_dir():
        die(f"no worktree for '{args.branch}' (stale entry? try: git worktree prune)")

    # Step out first if we're standing inside the worktree being removed
    cwd, target = Path.cwd().resolve(), path.resolve()
    inside = cwd == target or target in cwd.parents
    if inside:
        os.chdir(root)

    git("worktree", "remove", *(["--force"] if args.force else []), str(path), cwd=root)

    # Clean up empty parent dirs left by branch names like feat/auth
    base = root / WT_DIR
    parent = path.parent
    while parent != base:
        try:
            parent.rmdir()
        except OSError:
            break
        parent = parent.parent

    if inside:
        request_cd(root)

    if args.delete_branch:
        git("branch", "-d", args.branch, cwd=root)
    elif args.force_delete_branch:
        git("branch", "-D", args.branch, cwd=root)


def complete(kind: str) -> None:
    """Hidden `wt _complete <kind>` used by shell completion. Prints one name
    per line and stays silent on any error, so a broken repo never spams the
    prompt while you press Tab."""
    r = subprocess.run(
        ["git", "rev-parse", "--path-format=absolute", "--git-common-dir"],
        capture_output=True, text=True,
    )
    if r.returncode != 0:
        return
    root = Path(r.stdout.strip()).parent
    base = root / WT_DIR

    if kind == "worktrees":
        for line in git_out("worktree", "list", "--porcelain").splitlines():
            if line.startswith("worktree "):
                path = Path(line[len("worktree "):])
                if base in path.parents:
                    print(path.relative_to(base))
    elif kind == "branches":
        # Branches you can `wt add`: local ones not already checked out in a
        # worktree, plus remote branches with no local copy yet.
        seen = set()
        heads = git_out("for-each-ref", "--format=%(refname:short)%09%(worktreepath)",
                        "refs/heads")
        for line in heads.splitlines():
            name, _, wtpath = line.partition("\t")
            seen.add(name)
            if not wtpath:
                print(name)
        remotes = git_out("for-each-ref", "--format=%(refname:strip=3)", "refs/remotes")
        for name in sorted(set(remotes.splitlines()) - seen - {"HEAD", ""}):
            print(name)


def cmd_ls(args: argparse.Namespace) -> None:
    root = main_root()
    base = root / WT_DIR
    here = Path.cwd().resolve()

    # Parse `git worktree list --porcelain`: blank-line-separated blocks of
    # "worktree <path>", "HEAD <sha>", "branch refs/heads/<name>" / "detached"
    entries, cur = [], {}
    for line in git_out("worktree", "list", "--porcelain").splitlines() + [""]:
        if not line:
            if cur:
                entries.append(cur)
            cur = {}
            continue
        key, _, val = line.partition(" ")
        cur[key] = val if val else True

    def contains(p: Path) -> bool:
        return here == p or p in here.parents
    holders = [Path(e["worktree"]).resolve() for e in entries
               if contains(Path(e["worktree"]).resolve())]
    current_path = max(holders, key=lambda p: len(p.parts)) if holders else None

    rows = []
    for e in entries:
        path = Path(e["worktree"])
        rpath = path.resolve()
        if path == root:
            name = "(main)"
        elif base in path.parents:
            name = str(path.relative_to(base))
        else:
            name = str(path)                 # created outside the convention
        branch = e["branch"][len("refs/heads/"):] if "branch" in e else "(detached)"
        sha = e.get("HEAD", "")[:7]
        if "prunable" in e or not path.is_dir():
            state = "missing"                # dir deleted by hand; run git worktree prune
        else:
            dirty = subprocess.run(["git", "-C", str(path), "status", "--porcelain"],
                                   capture_output=True, text=True).stdout.strip()
            state = "modified" if dirty else ""
        current = "*" if rpath == current_path else " "
        rows.append((current, name, branch, sha, state, str(path)))

    w_name = max(len(r[1]) for r in rows)
    w_branch = max(len(r[2]) for r in rows)
    for current, name, branch, sha, state, path in rows:
        line = f"{current} {name:<{w_name}}  {branch:<{w_branch}}  {sha}  {state:<8}"
        if args.paths:
            line += f"  {path}"
        print(line.rstrip())


TOP_EPILOG = """\
examples:
  wt add feat-a          check out existing branch feat-a
  wt add -cg feat-b      create branch feat-b from current HEAD, cd into it
  wt cd feat-a           go to the feat-a worktree
  wt cd                  go back to the main checkout
  wt rm feat-a -d        remove the worktree and the (merged) branch
  wt ls                  list worktrees

Run 'wt help <command>' or 'wt <command> -h' for details on a command.
"""

LS_EPILOG = """\
Columns: current marker (*), worktree name, branch, commit, state.
State is "modified" when there are uncommitted changes, and "missing" when
the directory was deleted by hand (clean up with: git worktree prune).
"""

ADD_EPILOG = """\
Without -c the branch must already exist, locally or on a remote (a
remote-only branch gets a local tracking branch). With -c it must not exist.
"Current HEAD" is the HEAD of the worktree you're standing in.

examples:
  wt add feat-a              check out feat-a, stay where you are
  wt add -g feat-a           ...and cd into it
  wt add -cg fix/login-bug   create the branch, then cd into it
"""

CD_EPILOG = """\
examples:
  wt cd feat-a           go to .worktrees/feat-a
  wt cd                  go to the main checkout
"""

RM_EPILOG = """\
The branch is kept unless you pass -d or -D. If you run this from inside the
worktree being removed, you're moved to the main checkout first. With -d on
an unmerged branch, the worktree is removed but the branch is kept.

examples:
  wt rm feat-a           remove worktree, keep branch
  wt rm feat-a -d        ...and delete the branch if merged
  wt rm feat-a -fD       remove despite local changes, force-delete branch
"""


def build_parser() -> tuple[argparse.ArgumentParser, dict[str, argparse.ArgumentParser]]:
    fmt = argparse.RawDescriptionHelpFormatter

    def top_fmt(prog: str) -> argparse.HelpFormatter:
        return argparse.RawDescriptionHelpFormatter(prog, max_help_position=30)

    p = argparse.ArgumentParser(
        prog="wt",
        description="Manage git worktrees at <main checkout>/.worktrees/<branch>.",
        epilog=TOP_EPILOG,
        formatter_class=top_fmt,
    )
    sub = p.add_subparsers(dest="cmd", metavar="<command>", title="commands")
    cmds: dict[str, argparse.ArgumentParser] = {}

    def add_cmd(name: str, help_: str, epilog: str | None = None) -> argparse.ArgumentParser:
        sp = sub.add_parser(name, help=help_, description=help_[0].upper() + help_[1:] + ".",
                            epilog=epilog, formatter_class=fmt)
        cmds[name] = sp
        return sp

    a = add_cmd("add", "check out a branch into .worktrees/<branch>", ADD_EPILOG)
    a.add_argument("branch", help="branch to check out (or create with -c)")
    a.add_argument("-c", "--create", action="store_true",
                   help="create the branch from the current HEAD")
    a.add_argument("-g", "--cd", dest="go", action="store_true",
                   help="cd into the new worktree afterwards")
    a.set_defaults(func=cmd_add)

    c = add_cmd("cd", "go to a worktree, or the main checkout with no branch", CD_EPILOG)
    c.add_argument("branch", nargs="?", help="worktree to go to (omit for main checkout)")
    c.set_defaults(func=cmd_cd)

    r = add_cmd("rm", "remove a worktree, optionally its branch too", RM_EPILOG)
    r.add_argument("branch", help="worktree to remove")
    r.add_argument("-f", "--force", action="store_true",
                   help="remove even with uncommitted changes")
    g = r.add_mutually_exclusive_group()
    g.add_argument("-d", "--delete-branch", action="store_true",
                   help="also delete the branch, only if merged (git branch -d)")
    g.add_argument("-D", "--force-delete-branch", action="store_true",
                   help="also delete the branch even if unmerged (git branch -D)")
    r.set_defaults(func=cmd_rm)

    l = add_cmd("ls", "list worktrees", LS_EPILOG)
    l.add_argument("-p", "--paths", action="store_true", help="also show full paths")
    l.set_defaults(func=cmd_ls)

    h = add_cmd("help", "show help for wt or one of its commands")
    h.add_argument("command", nargs="?", help="command to show help for")
    h.set_defaults(func=None)

    return p, cmds


def main() -> None:
    if len(sys.argv) == 3 and sys.argv[1] == "_complete":
        complete(sys.argv[2])
        return

    parser, cmds = build_parser()
    args = parser.parse_args()

    if args.cmd is None:              # bare `wt`
        parser.print_help()
        return
    if args.cmd == "help":
        if args.command is None:
            parser.print_help()
        elif args.command in cmds:
            cmds[args.command].print_help()
        else:
            die(f"unknown command '{args.command}' (try: wt help)")
        return

    args.func(args)


if __name__ == "__main__":
    main()
