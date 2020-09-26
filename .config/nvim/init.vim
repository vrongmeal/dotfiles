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
" Hello, World! This is my `.config/nvim/init.vim`
"
" P.S. This config is supposed to work on both vim and neovim but it doesn't
" (I don't know why, neither did I try to configure it as well).
" If you do want to use it in vim, do change the "plugged" path (first line in
" the pluggins section) to "~/.vim/plugged", or add
"
" ==============================================================================


" ==============================================================================
" Improve vi
"
set nocompatible
"
" ==============================================================================

" ==============================================================================
" Manage plugins using vim-plug
"
call plug#begin('~/.config/nvim/plugged')

	" Language Server Protocol (LSP) client implementation
	Plug 'autozimu/LanguageClient-neovim', {
		\ 'branch': 'next',
		\ 'do': 'bash install.sh',
		\ }

	" Autocomplete (because omnifunc sucks)
	" Also there is no excuse because this is suppose to work with LSP client
	" and there if on remote systems you don't have this, you definitely don't
	" have LSP client installed.
	if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/deoplete.nvim'
		Plug 'roxma/nvim-yarp'
		Plug 'roxma/vim-hug-neovim-rpc'
	endif

	" Change settings according to the .editorconfig file
	Plug 'editorconfig/editorconfig-vim'

	" TOML Syntax
	Plug 'cespare/vim-toml'

	" Some of the colorschemes that I like
	Plug 'jacoborus/tender.vim'
	Plug 'sainnhe/sonokai'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'doums/darcula'

call plug#end()
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
" Colors
"
set background=dark
colorscheme darcula

" Set these backgrounds to transparent irrespective of color scheme
hi! Normal ctermbg=NONE guibg=NONE
hi! EndOfBuffer ctermbg=None guibg=None
hi! LineNr ctermbg=None guibg=None
hi! CursorLine ctermbg=None guibg=None
hi! CursorLineNr ctermbg=None guibg=None
hi! VertSplit ctermbg=None guibg=None
hi! NonText ctermbg=NONE guibg=NONE

hi StatusLine ctermbg=NONE guibg=NONE ctermfg=white guifg=white
"
" ==============================================================================

" ==============================================================================
" Key bindings
"
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-N> :bnext<cr>
nnoremap <C-P> :bprev<cr>
nnoremap <C-W> :bdelete<cr>
nnoremap <C-Q> :bdelete!<cr>

" Delete only, not copy while delete
nnoremap d "_d
vnoremap d "_d
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
" Custom syntax
"
" Override default go syntax with custom syntax
" Default is not so much colored, this syntax is copied from vim-go and
" modified accordingly.
au Syntax go runtime! syntax/go.vim
au BufReadPost go.mod set syntax=gomod
au BufReadPost go.sum set syntax=gomod
"
" ==============================================================================

" ==============================================================================
" Deoplete settings
"
" Disable truncation
call deoplete#custom#source('_', 'max_abbr_width', 0)

let g:deoplete#enable_at_startup = 1

" Close preview window once autocomplete is done
autocmd CompleteDone * silent! pclose!
"
" ==============================================================================

" ==============================================================================
" LSP Client configuration
"
" Required apparently
set hidden

" Language servers
let g:LanguageClient_serverCommands = {
    \ 'go':  ['gopls'],
    \ 'cpp': ['clangd', '--fallback-style=llvm'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }

" Shortcuts for LSP commands
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap gr :call LanguageClient#textDocument_rename()<CR>
nnoremap gf :call LanguageClient#textDocument_formatting()<CR>
nnoremap gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap gx :call LanguageClient#textDocument_references()<CR>
nnoremap ge :call LanguageClient_workspace_applyEdit()<CR>
nnoremap gc :call LanguageClient#textDocument_completion()<CR>
nnoremap gh :call LanguageClient#textDocument_hover()<CR>
nnoremap gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap gm :call LanguageClient_contextMenu()<CR>
nnoremap ga :call LanguageClient#textDocument_codeAction()<CR>

" Format these files on save
autocmd BufWritePre *.go,*.c,*.cc,*.cpp,*.rs,*.js,*.ts
    \ :call LanguageClient#textDocument_formatting_sync()
"
" ==============================================================================

" ==============================================================================
" Indentations (defaults, can be overridden by .editorconfig)
"
" Tabs (4) -- Default for all files
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Spaces (2)
au FileType javascript,markdown,yaml,json set expandtab
au FileType javascript,markdown,yaml,json set shiftwidth=2
au FileType javascript,markdown,yaml,json set softtabstop=2
au FileType javascript,markdown,yaml,json set tabstop=2

" Spaces (4)
au FileType python,rust,toml set expandtab
au FileType python,rust,toml set shiftwidth=4
au FileType python,rust,toml set softtabstop=4
au FileType python,rust,toml set tabstop=4
"
" ==============================================================================
