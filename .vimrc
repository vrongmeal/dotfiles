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
set colorcolumn=+1

" Set language for spelling but disable it by default
" Can enable it again by :set spell
set spell spelllang=en_us
set nospell

" Set <space> as leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Comment this out and try to use vim without the mouse for practice.
" N.B.: This is not for being cool. When not using laptop, i.e., not having
" access to the trackpad, using the mouse tires and breaks the flow of typing.
" It would be nice if you don't use the mouse and rather just the keyboard.
" if has('mouse')
" 	set mouse=a
" endif

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
noremap <leader>d "_d
noremap <leader>c "_c

" Toggle mouse behaviour
" N.B.: There is no definite way to actually disable the mouse, so when
" toggling to off, we actually just enable it in the command-line only mode.
noremap <leader>mm :set mouse=a<CR>
noremap <leader>md :set mouse=c<CR>
"
" ==============================================================================

" ==============================================================================
" Comments
"
" TODO(vrongmeal): You can do a better job with improving the quality of
" commenting/uncommenting the lines. The perfect behaviour would be to
" preserve the indentation. For example there is a code that goes like the
" following:
"
"	def my_python_function():
"	    pass
"
" Commented version of the above code should be:
"
"	# def my_python_function():
"	#     pass
"
" HINT: See how you can replicate ^ Ctrl-V Shift-I behaviour with the vim script
" and for uncommenting use the ^ Ctrl-V del. (Prefer using substitute for
" uncommenting).
"
" Before you can reach here, one milestone to accomplish would be to make the
" uncomment function work with indented comment blocks.
"
" ==============================================================================

" ==============================================================================
" Status Line (or as called status bar in other editors)
"
set statusline=
set statusline+=%#StatusLine#
set statusline+=%f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=%y
set statusline+=\ %c\ :\ %l/%L
"
" ==============================================================================

" ==============================================================================
" Indentations (defaults, can be overridden by .editorconfig)
"
" 4 Tab -- Default for all files
set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" 2 Spaces
autocmd FileType
	\ html,css,javascript,typescript,markdown,yaml,json
	\ set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" 4 Spaces
autocmd FileType
	\ python,rust,toml,c,cpp,lua
	\ set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
"
" ==============================================================================

" ==============================================================================
" External Programs
"
" Use ripgrep (rg) instead of grep in vim
if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" ==============================================================================
