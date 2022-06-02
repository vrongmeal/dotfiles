source ~/.vimrc

call plug#begin('~/.config/nvim/plugged')

	" Language Server Protocol (LSP) client implementation
	Plug 'neovim/nvim-lspconfig'

	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Autocomplete (using Deoplete)
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'deoplete-plugins/deoplete-lsp'
	" Function signatures
	Plug 'ray-x/lsp_signature.nvim'

	" Change settings according to the .editorconfig file
	Plug 'editorconfig/editorconfig-vim'

	" TOML Syntax
	Plug 'cespare/vim-toml'

	" Some of the colorschemes that I like
	Plug 'jacoborus/tender.vim'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'doums/darcula'
	Plug 'ayu-theme/ayu-vim'
	Plug 'flrnd/candid.vim'
	Plug 'projekt0n/github-nvim-theme'
	Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
	Plug 'srcery-colors/srcery-vim'
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

	" Some plugins I might need on another systems (alternatives when
	" something's not available).
	" Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

" Colors
set background=dark
let ayucolor="dark"
set termguicolors
colorscheme srcery

" Comments color in warp is a little darker than I like
" hi! Comment ctermfg=254 guifg=#e4e4e4 cterm=italic gui=italic
hi! Comment cterm=italic gui=italic

" Set these backgrounds to transparent irrespective of color scheme
hi! Normal       ctermbg=None guibg=None
hi! EndOfBuffer  ctermbg=None guibg=None
hi! LineNr       ctermbg=None guibg=None
hi! CursorLine   ctermbg=None guibg=None
hi! CursorLineNr ctermbg=None guibg=None
hi! VertSplit    ctermbg=None guibg=None
hi! NonText      ctermbg=None guibg=None

" Sometimes this might need some editing for different color schemes
" if &background == "dark"
"     hi StatusLine ctermbg=NONE guibg=NONE ctermfg=white guifg=white
" else
"     hi StatusLine ctermbg=NONE guibg=NONE ctermfg=black guifg=black
" endif

" Alternative plugins config
"
" Enhanced CPP highlight
" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1
" let g:cpp_posix_standard = 1
" let g:cpp_experimental_simple_template_highlight = 0
" let g:cpp_experimental_template_highlight = 1
" let g:cpp_concepts_highlight = 1
" let g:cpp_no_function_highlight = 0
"
" Override default go syntax with custom syntax
" Default is not so much colored, this syntax is copied from vim-go and
" modified accordingly.
" autocmd Syntax go runtime! syntax/go.vim
" autocmd BufNewFile,BufRead go.mod,go.sum set filetype=gomod
" autocmd BufReadPost go.mod,go.sum set syntax=gomod

" Deoplete and Echodoc settings

" Disable truncation
call deoplete#custom#source('_', 'max_abbr_width', 0)

call deoplete#custom#option({
	\ 	'smart_case': v:false,
	\ 	'ignore_case': v:true,
	\ })

let g:deoplete#enable_at_startup = 1

" Close preview window once autocomplete is done
autocmd CompleteDone * silent! pclose!

" Deoplete lsp settings
let g:deoplete#lsp#handler_enabled = v:true
let g:deoplete#lsp#use_icons_for_candidates = v:false

" Treesitter
" See lua/treesitter.lua
lua require('treesitter')

" LSP Client configuration (and autocomplete)
" See lua/lsp.lua
lua require('lsp')
