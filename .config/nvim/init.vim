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

	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Autocomplete (using Deoplete)
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'deoplete-plugins/deoplete-lsp'

	" Change settings according to the .editorconfig file
	Plug 'editorconfig/editorconfig-vim'

	" Bazel support
	Plug 'google/vim-maktaba'
	Plug 'bazelbuild/vim-bazel'

	" TOML Syntax
	Plug 'cespare/vim-toml'

	" Status Line
	Plug 'itchyny/lightline.vim'

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
let ayucolor="dark"
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
" Lightline (Statusline and Tabline)
"
" Show full path of filename
function! FilenameForLightline()
    return expand('%')
endfunction

set noshowmode
let g:lightline = {
	\	'colorscheme': 'powerline',
	\	'component': {
	\		'lineinfo': '%3l:%-2v [%L]',
	\	},
	\	'component_function': {
	\		'filename': 'FilenameForLightline'
	\	}
	\ }
"
" ==============================================================================

" ==============================================================================
" Deoplete settings
"
" Disable truncation
call deoplete#custom#source('_', 'max_abbr_width', 0)

call deoplete#custom#option({
	\	'auto_complete_delay': 200,
	\	'smart_case': v:true,
	\	'ignore_case': v:true,
	\ })

let g:deoplete#enable_at_startup = 1

" Close preview window once autocomplete is done
autocmd CompleteDone * silent! pclose!

" Deoplete lsp settings
let g:deoplete#lsp#handler_enabled = v:true
let g:deoplete#lsp#use_icons_for_candidates = v:true
"
" ==============================================================================

" ==============================================================================
" Treesitter
"
" See lua/treesitter.lua
lua require('treesitter')
"
" ==============================================================================

" ==============================================================================
" LSP Client configuration (and autocomplete)
"
" See lua/lsp.lua
lua require('lsp')
"
" ==============================================================================
