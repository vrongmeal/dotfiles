set nocompatible

filetype plugin indent on
syntax enable
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
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
set breakindent
set undofile
set signcolumn
if has('nvim') || has('termguicolors')
  set termguicolors
endif
set splitbelow
set splitright
set laststatus=2
set cursorline
set colorcolumn=0
set list
set showbreak=↪\
set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:·,trail:_

" Set language for spelling but disable it by default
" Can enable it again by :set spell
set spell spelllang=en_us
set nospell

" Set <space> as leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

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
noremap <leader>d "_d
noremap <leader>c "_c

" Toggle mouse behaviour
" N.B.: There is no definite way to actually disable the mouse, so when
" toggling to off, we actually just enable it in the command-line only mode.
if has('mouse')
	noremap <leader>mm :set mouse=a<CR>
	noremap <leader>md :set mouse=c<CR>
endif

" Status Line (or as called status bar in other editors)
set statusline=
set statusline+=%#StatusLine#
set statusline+=\%f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=%y
set statusline+=\ %2c:%-3l\ %L

" Indentations (defaults, can be overridden by .editorconfig)

" 4 Tab -- Default for all files
set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" 2 Spaces
autocmd FileType
	\ html,css,javascript,typescript,markdown,yaml,json,lua
	\ set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" 4 Spaces
autocmd FileType
	\ python,rust,toml,c,cpp,bzl
	\ set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" External Programs

" Use ripgrep (rg) instead of grep in vim
if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
