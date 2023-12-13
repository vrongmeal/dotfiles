-- Set leader to <SPACE>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers (but relative)
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.numberwidth = 7

-- Share clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Don't create a swap file
vim.opt.swapfile = false

-- TODO: Figure out how to listchars?

-- Needed for some terminals
vim.opt.termguicolors = true

-- Set a default colorscheme to something nice
vim.cmd.colorscheme "habamax"

-- Define file indents
local function set_file_indent(size, use_space)
  vim.opt.tabstop = size
  vim.opt.shiftwidth = size
  vim.bo.softtabstop = size
  vim.opt.expandtab = use_space
end

-- By default use tab for files 
set_file_indent(4, false)

-- Files to use 2 spaces with
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "css",
    "javascript",
    "typescript",
    "markdown",
    "yaml",
    "json",
    "lua",
  },
  callback = function(args)
    set_file_indent(2, true)
  end
})

-- Files to use 4 spaces with
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "python",
    "rust",
    "toml",
    "c",
    "cpp",
    "bzl",
  },
  callback = function(args)
    set_file_indent(4, true)
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Briefly highlight yanked text",
})
