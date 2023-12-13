local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Which Key for keybindings and showing them nicely.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 100
    end,
    opts = {},
  },
  -- Neovim Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
  },
  -- Buffer line
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    version = "*",
  },
}

require("lazy").setup(plugins, {})
