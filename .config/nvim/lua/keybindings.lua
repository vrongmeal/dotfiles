local whichkey = require "which-key"
local telescope_builtin = require "telescope.builtin"

local leader_keybindings = {
  f = {
    telescope_builtin.find_files,
    "Open file picker",
  },
  b = {
    telescope_builtin.buffers,
    "Open buffer picker",
  },
  ['/'] = {
    telescope_builtin.live_grep,
    "Live grep",
  },
  j = {
    telescope_builtin.jumplist,
    "Open jumplist picker",
  },
}

whichkey.register(leader_keybindings, { prefix = "<leader>" })

local g_keybindings = {
  n = {
    "<cmd>bn<cr>",
    "Goto next file"
  },
  p = {
    "<cmd>bp<cr>",
    "Goto previous file"
  },
}

whichkey.register(g_keybindings, { prefix = "g" })
