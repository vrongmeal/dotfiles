# dotfiles

> Setup for my macOS

- I use [Kitty](https://sw.kovidgoyal.net/kitty/) as my terminal emulator with
  ZSH (customized with [Oh My ZSH](https://ohmyz.sh/)).

- I write code on [Neovim](https://neovim.io/), [Vim Plug](https://github.com/junegunn/vim-plug)
  for plugin management. My plugins majorly include [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
  for language server client support, [Deoplete](https://github.com/Shougo/deoplete.nvim)
  for autocomplete (because omnifunc sucks) and a couple others for syntax support.
  Rest, there might be a lot of colorschemes.

- [Google Chrome](https://www.google.com/intl/en_in/chrome/) is my default web
  browser only because I have an android phone and I apparently use a lot of
  bookmarks and syncing.

- For viewing diffs side by side, I don't use the built-in kitten (kitty plugin),
  rather a tool called [ydiff](https://github.com/ymattw/ydiff). Other than that,
  I love using git from the command line in it's purest form.

## Run

The script `run` installs everything that I require.

```sh
$ ./run
```
