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
" the pluggins section) to "~/.vim/plugged".
"
" ==============================================================================

source ~/.vimrc

" ==============================================================================
" Manage plugins using vim-plug
"
call plug#begin('~/.config/nvim/plugged')

	" Language Server Protocol (LSP) client implementation
	Plug 'neovim/nvim-lspconfig'
" 	Plug 'autozimu/LanguageClient-neovim', {
" 		\ 'branch': 'next',
" 		\ 'do': 'bash install.sh',
" 		\ }

	" Bazel support
	Plug 'google/vim-maktaba'
	Plug 'bazelbuild/vim-bazel'

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
	" Deoplete support for nvim-lsp
	Plug 'deoplete-plugins/deoplete-lsp'

	" Better C++ Syntax
	Plug 'octol/vim-cpp-enhanced-highlight'

	" Change settings according to the .editorconfig file
	Plug 'editorconfig/editorconfig-vim'

	" TOML Syntax
	Plug 'cespare/vim-toml'

	" Some of the colorschemes that I like
	Plug 'jacoborus/tender.vim'
	Plug 'sainnhe/sonokai'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'doums/darcula'
	Plug 'ayu-theme/ayu-vim'

call plug#end()
"
" ==============================================================================

" ==============================================================================
" Colors
"
set background=dark
let ayucolor="mirage"
colorscheme ayu

" Set these backgrounds to transparent irrespective of color scheme
hi! Normal ctermbg=NONE guibg=NONE
hi! EndOfBuffer ctermbg=None guibg=None
hi! LineNr ctermbg=None guibg=None
hi! CursorLine ctermbg=None guibg=None
hi! CursorLineNr ctermbg=None guibg=None
hi! VertSplit ctermbg=None guibg=None
hi! NonText ctermbg=NONE guibg=NONE

" Sometimes this might need some editing for different color schemes
if &background == "dark"
    hi StatusLine ctermbg=NONE guibg=NONE ctermfg=white guifg=white
else
    hi StatusLine ctermbg=NONE guibg=NONE ctermfg=black guifg=black
endif
"
" ==============================================================================

" ==============================================================================
" Custom syntax
"
" Override default go syntax with custom syntax
" Default is not so much colored, this syntax is copied from vim-go and
" modified accordingly.
autocmd Syntax go runtime! syntax/go.vim
autocmd BufNewFile,BufRead go.mod,go.sum set filetype=gomod
autocmd BufReadPost go.mod,go.sum set syntax=gomod

" C++ Syntax Settings
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 0
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 0
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

" Deoplete lsp settings
let g:deoplete#lsp#handler_enabled = v:true
let g:deoplete#lsp#use_icons_for_candidates = v:false
"
" ==============================================================================

lua require('lsp')

" " ==============================================================================
" " LSP Client configuration
" "
" " Required apparently
" set hidden
"
" " Language servers
" let g:LanguageClient_serverCommands = {
" 	\ 'go':   ['gopls'],
" 	\ 'c':    ['clangd'],
" 	\ 'cpp':  ['clangd'],
" 	\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
" 	\ }
"
" " Shortcuts for LSP commands
" nnoremap gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap gr :call LanguageClient#textDocument_rename()<CR>
" nnoremap gf :call LanguageClient#textDocument_formatting()<CR>
" nnoremap gt :call LanguageClient#textDocument_typeDefinition()<CR>
" nnoremap gx :call LanguageClient#textDocument_references()<CR>
" nnoremap ge :call LanguageClient_workspace_applyEdit()<CR>
" nnoremap gc :call LanguageClient#textDocument_completion()<CR>
" nnoremap gh :call LanguageClient#textDocument_hover()<CR>
" nnoremap gs :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap gm :call LanguageClient_contextMenu()<CR>
" nnoremap ga :call LanguageClient#textDocument_codeAction()<CR>
"
" " Format these files on save
" autocmd BufWritePre
" 	\ *.go,*.h,*.c,*.cc,*.hh,*.cpp,*.hpp,*.rs
" 	\ :call LanguageClient#textDocument_formatting_sync()
" "
" " ==============================================================================
