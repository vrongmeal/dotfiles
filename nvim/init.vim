" -------
" Plugins
" -------

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'rbgrouleff/bclose.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'pangloss/vim-javascript'
Plug 'leafoftree/vim-vue-plugin'
Plug 'deoplete-plugins/deoplete-jedi'

" Colorscheme
Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()

" ---

" -----------------
" My Configurations
" -----------------

filetype plugin indent on
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
set number
set numberwidth=7
set clipboard=unnamed
set incsearch
set ignorecase
set smartcase
set nohlsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noswapfile
syntax enable
set cursorline
set t_Co=256
set termguicolors
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let ayucolor="mirage"
colorscheme palenight
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <leader>n :bnext<cr>
nnoremap <leader>p :bprev<cr>
set splitbelow
set splitright
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>
nnoremap <leader>q :close<cr>

" Use mouse if possible
if has('mouse')
	set mouse=a
endif

" ---

" Monokai Theme
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" Spacegray theme
let g:spacegray_underline_search = 1
let g:spacegray_use_italics = 1
let g:spacegray_low_contrast = 1

" Bclose
nnoremap <leader>w :Bclose<cr>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" ----------------
" NERDTree Configs
" ----------------

" Open on startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Open when folder specified as `nvim ~/some-dir`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close when the only buffer left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Toggle
map <leader>t :NERDTreeToggle<CR>

" Refresh
map <leader><space> :NERDTreeRefreshRoot<CR>

" Disply
let g:NERDTreeDirArrowExpandable = '❯'
let g:NERDTreeDirArrowCollapsible = '-'

" Show hidden files by default
let NERDTreeShowHidden = 1

" ---

" ---------------------
" NERDCommenter Configs
" ---------------------

filetype plugin on " Required apparently

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Comment using //
nmap // <leader>c<space>
vmap // <leader>cs

" ---

" Vim-Airline Config
let g:airline#extensions#tabline#enabled = 1

" Vim Multiple cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_skip_key='<C-b>'

" Neomake
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
let g:neomake_open_list    = 2
nnoremap <leader>m :Neomake<cr>
nnoremap <leader>M :NeomakeFile<cr>

" Neoformat
nnoremap <leader>f :Neoformat<cr>

" Golang
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
"let g:go_auto_sameids = 1
let g:go_fmt_command = "goreturns"
let g:go_auto_type_info = 1
let g:deoplete#sources#go#gocode_binary = '/Users/vrongmeal/bin/gocode'
let g:neomake_go_enabled_makers = [ 'go', 'govet' ]

" Javascript
au FileType js,ts,vue set expandtab
au FileType js,ts,vue set shiftwidth=2
au FileType js,ts,vue set softtabstop=2
au FileType js,ts,vue set tabstop=2
let g:neomake_javascript_enabled_makers = ['eslint']

" Vue specific
let g:vim_vue_plugin_use_sass = 1
let g:vim_vue_plugin_highlight_vue_attr = 1
let g:vim_vue_plugin_debug = 1
