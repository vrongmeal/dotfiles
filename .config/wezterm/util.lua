local wezterm = require 'wezterm'

local M = {}

function M.bind_split_pane_key(direction, key, mods)
  return {
    mods = mods,
    key = key,
    action = wezterm.action.SplitPane {
      direction = direction,
      size = { Percent = 50 },
    },
  }
end

function M.bind_activate_pane_key(direction, key, mods)
  return {
    mods   = mods,
    key    = key,
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

function M.bind_rotate_pane_key(direction, key, mods)
  return {
    mods = mods,
    key = key,
    action = wezterm.action.RotatePanes(direction),
  }
end

function M.is_dark_appearance()
  if wezterm.gui then
    local app = wezterm.gui.get_appearance()
    if app:find 'Dark' then
      return true
    else
      return false
    end
  end
  -- Default to 'true' if cannot figure out.
  return true
end

return M
