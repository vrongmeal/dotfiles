local lualine = require "lualine"
local bufferline = require "bufferline"

-- TODO: Make something cool like evil-line?
-- Or just customize the shit out of this.

lualine.setup({
  options = {
    theme = "powerline",
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
})

bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.minimal,
  },
})
