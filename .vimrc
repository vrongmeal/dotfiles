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
" Some default settings for vim as an editor.
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

" Disable NETRW
let loaded_netrwPlugin = 1
"
" ==============================================================================

" ==============================================================================
" Key bindings
"
nnoremap <leader>b :buffers<cr>
nnoremap <C-N> :bnext<cr>
nnoremap <C-P> :bprev<cr>
nnoremap <C-W> :bdelete<cr>
nnoremap <C-Q> :bdelete!<cr>

" Delete only, not copy while delete
nnoremap <leader>d "_d
vnoremap <leader>d "_d
xnoremap <leader>d "_d
"
" ==============================================================================
