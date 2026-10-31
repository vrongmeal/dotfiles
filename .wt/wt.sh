# wt.sh: shell wrapper and tab completion for wt.py (bash & zsh)
# Source it from ~/.bashrc or ~/.zshrc:   source ~/path/to/wt.sh
# zsh: source it *after* compinit runs (after oh-my-zsh / your plugin manager).
#
# wt.py does the work; the `wt` function exists only so `wt add -g` / `wt cd` /
# `wt rm` can change your shell's directory, which a program can't do itself.
# wt.py is looked up next to this file; set WT_PY to override.

if [ -n "$ZSH_VERSION" ]; then
  : "${WT_PY:=${${(%):-%x}:A:h}/wt.py}"
else
  : "${WT_PY:=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/wt.py}"
fi

wt() {
  local cdfile dir rc
  cdfile=$(mktemp) || return 1
  WT_CD_FILE="$cdfile" python3 "$WT_PY" "$@"
  rc=$?
  dir=$(cat "$cdfile")
  rm -f "$cdfile"
  [ -n "$dir" ] && cd "$dir"
  return $rc
}

# ---------------------------------------------------------------- completion

if [ -n "$ZSH_VERSION" ]; then

  _wt_worktrees() {
    local -a names
    names=(${(f)"$(python3 "$WT_PY" _complete worktrees 2>/dev/null)"})
    compadd -a names
  }

  _wt_branches() {
    local -a names
    names=(${(f)"$(python3 "$WT_PY" _complete branches 2>/dev/null)"})
    compadd -a names
  }

  _wt() {
    local -a cmds
    cmds=(
      'add:check out a branch into .worktrees/<branch>'
      'cd:go to a worktree, or the main checkout'
      'rm:remove a worktree, optionally its branch too'
      'ls:list worktrees'
      'help:show help for wt or one of its commands'
    )
    if (( CURRENT == 2 )); then
      _describe -t commands 'wt command' cmds
      return
    fi
    # Drop "wt" so _arguments sees the subcommand as the command name
    words=("${(@)words[2,-1]}")
    (( CURRENT-- ))
    case $words[1] in
      add)
        _arguments -s \
          '(-c --create)'{-c,--create}'[create the branch from the current HEAD]' \
          '(-g --cd)'{-g,--cd}'[cd into the new worktree afterwards]' \
          '1:branch:_wt_branches' ;;
      cd)
        _arguments '1:worktree:_wt_worktrees' ;;
      rm)
        _arguments -s \
          '(-f --force)'{-f,--force}'[remove even with uncommitted changes]' \
          '(-d --delete-branch -D --force-delete-branch)'{-d,--delete-branch}'[also delete the branch, only if merged]' \
          '(-d --delete-branch -D --force-delete-branch)'{-D,--force-delete-branch}'[also delete the branch even if unmerged]' \
          '1:worktree:_wt_worktrees' ;;
      ls)
        _arguments '(-p --paths)'{-p,--paths}'[also show full paths]' ;;
      help)
        _arguments '1:command:(add cd rm ls help)' ;;
    esac
  }

  if (( $+functions[compdef] )); then
    compdef _wt wt
  else
    print -u2 "wt.sh: compinit hasn't run yet; source wt.sh after it to get completion"
  fi

elif [ -n "$BASH_VERSION" ]; then

  _wt_bash() {
    local cur=${COMP_WORDS[COMP_CWORD]} cmd=${COMP_WORDS[1]} opts="" list=""
    COMPREPLY=()

    if (( COMP_CWORD == 1 )); then
      COMPREPLY=($(compgen -W "add cd rm ls help" -- "$cur"))
      return
    fi

    case $cmd in
      add)  opts="-c --create -g --cd -h --help"
            list=$(python3 "$WT_PY" _complete branches 2>/dev/null) ;;
      cd)   opts="-h --help"
            list=$(python3 "$WT_PY" _complete worktrees 2>/dev/null) ;;
      rm)   opts="-f --force -d --delete-branch -D --force-delete-branch -h --help"
            list=$(python3 "$WT_PY" _complete worktrees 2>/dev/null) ;;
      ls) opts="-p --paths -h --help" ;;
      help) (( COMP_CWORD == 2 )) && list="add cd rm ls help" ;;
    esac

    if [[ $cur == -* ]]; then
      COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    else
      COMPREPLY=($(compgen -W "$list" -- "$cur"))
    fi
  }

  complete -F _wt_bash wt

fi
