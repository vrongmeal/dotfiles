" ==============================================================================
"
"  ___      ___ ________  ________  ________   ________  _____ ______   _______   ________  ___
" |\  \    /  /|\   __  \|\   __  \|\   ___  \|\   ____\|\   _ \  _   \|\  ___ \ |\   __  \|\  \
" \ \  \  /  / | \  \|\  \ \  \|\  \ \  \\ \  \ \  \___|\ \  \\\__\ \  \ \   __/|\ \  \|\  \ \  \
"  \ \  \/  / / \ \   _  _\ \  \\\  \ \  \\ \  \ \  \  __\ \  \\|__| \  \ \  \_|/_\ \   __  \ \  \
"   \ \    / /   \ \  \\  \\ \  \\\  \ \  \\ \  \ \  \|\  \ \  \    \ \  \ \  \_|\ \ \  \ \  \ \  \____
"    \ \__/ /     \ \__\\ _\\ \_______\ \__\\ \__\ \_______\ \__\    \ \__\ \_______\ \__\ \__\ \_______\
"     \|__|/       \|__|\|__|\|_______|\|__| \|__|\|_______|\|__|     \|__|\|_______|\|__|\|__|\|_______|
"
"
" Hello, World! This is my `.vimrc`
"
" ==============================================================================


" ==============================================================================
" Improve vi
"
set nocompatible
"
" ==============================================================================

" ==============================================================================
" Basic editor configurations
"
filetype plugin indent on
syntax enable
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
set listchars=tab:→\ ,space:⋅,
set list
set number relativenumber
set numberwidth=7
set clipboard=unnamed
set incsearch
set ignorecase
set smartcase
set nohlsearch
set noswapfile
set conceallevel=0
set cmdheight=1
set wildmenu
set t_Co=256
set termguicolors
set splitbelow
set splitright
set laststatus=2
set cursorline

" Set language for spelling but disable it by default
" Can enable it again by :set spell
set spell spelllang=en_us
set nospell

" Set <space> as leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Use mouse if possible
if has('mouse')
	set mouse=a
endif

" Don't show line numbers with terminal.
if has('nvim')
	augroup TerminalStuff
		au!
		autocmd TermOpen * setlocal nonumber norelativenumber
	augroup END
endif

" Remove trailing whitespace when saving file
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" NETRW Settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 0
"
" ==============================================================================

" ==============================================================================
" Key bindings
"
" :ls  -> List all buffers
" :b#  -> Go to buffer #
" :bn  -> Go to next buffer
" :bp  -> Go to previous buffer
" :bd  -> Delete current buffer
" :bd! -> Force delete the current buffer

" NETRW
" :Ex -> Open in current window

" Delete only, not copy while delete
nnoremap <leader>d "_d
vnoremap <leader>d "_d
xnoremap <leader>d "_d
"
" ==============================================================================

" ==============================================================================
" Status Line (or as called status bar in other editors)
"
set statusline=
set statusline+=%f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=%y
set statusline+=\ %c\ :\ %l/%L
set statusline+=
"
" ==============================================================================

" ==============================================================================
" Indentations (defaults, can be overridden by .editorconfig)
"
" 4 Tab -- Default for all files
set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" 2 Spaces
autocmd FileType
	\ html,css,javascript,markdown,yaml,json
	\ set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" 4 Spaces
autocmd FileType
	\ python,rust,toml,c,cpp,lua
	\ set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
"
" ==============================================================================
