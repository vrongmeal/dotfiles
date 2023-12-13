local wezterm = require 'wezterm'
local util = require 'util'

local M = {}

local function make_specific_colors(colors, defaults)
  return {
    color_scheme = colors.color_scheme or defaults.color_scheme,
    split = colors.split or defaults.split,
    cursor_fg = colors.cursor or defaults.cursor,
  }
end

local function make_colors(colors)
  local dark_appearance = util.is_dark_appearance() 
  local colors = {}
  if dark_appearance then
    return make_specific_colors(colors.dark or {}, {
      color_scheme = "Gruber (base16)",
      split = "#555555",
      cursor_fg = 'black',
    })
  else
    return make_specific_colors(colors.light or {}, {
      color_scheme = "Cupertino (base16)",
      split = "#AAAAAA",
      cursor_fg = 'white',
    })
  end
end

local function make_font(font)
  -- Font ligatures (enabled by default).
  -- TODO: Disable them by default?
  local harfbuzz_features = nil
  if not font.ligatures then
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
  end

  return {
    family = font.family or 'Menlo',
    size = font.size or 13,
    line_height = font.line_height or 1,
    cell_width = font.cell_width or 1,
    harfbuzz_features = harfbuzz_features,
  }
end

function M.make(conf)
  local font = make_font(conf.font or {})
  local colors = make_colors(conf.colors or {})

  return {
    font = wezterm.font(font.family),
    font_size = font.size,
    line_height = font.line_height,
    cell_width = font.cell_width,
    harfbuzz_features = font.harfbuzz_features,

    -- So we have everything running in background :)
    native_macos_fullscreen_mode = false,
    hide_tab_bar_if_only_one_tab = false,

    -- Scrollbar (a tiny one on the side)
    enable_scroll_bar = true,
    min_scroll_bar_height = "1cell",

    -- Color settings (based on background)
    color_scheme = colors.color_scheme,
    colors = {
      split = colors.split,
      cursor_fg = colors.cursor_fg,
    },

    window_padding = {
      left = '0.5cell',
      right = '0.5cell',
      top = '0.1cell',
      bottom = '0cell',
    },

    window_background_opacity = 0.9,
    macos_window_background_blur = 25,

    -- Dim the lights when switching panes
    inactive_pane_hsb = {
      hue = 1,
      saturation = 0.7,
      brightness = 0.3,
    },

    -- Control cursor animation (don't like the slow blinking)
    default_cursor_style = 'SteadyBlock',
    animation_fps        = 1,
    cursor_blink_rate    = 700,

    -- Keybindings
    keys = {
      -- Split pane keys
      util.bind_split_pane_key('Up', 'a', 'SUPER|SHIFT'),
      util.bind_split_pane_key('Down', 'd', 'SUPER|SHIFT'),
      util.bind_split_pane_key('Left', 'a', 'SUPER'),
      util.bind_split_pane_key('Right', 'd', 'SUPER'),

      -- Switch/Activate to another pane
      util.bind_activate_pane_key('Up', 'UpArrow',    'SUPER|ALT'),
      util.bind_activate_pane_key('Down', 'DownArrow',  'SUPER|ALT'),
      util.bind_activate_pane_key('Left', 'LeftArrow',  'SUPER|ALT'),
      util.bind_activate_pane_key('Right', 'RightArrow', 'SUPER|ALT'),
      -- Switch/Activate to another pane using vim-like bindings
      util.bind_activate_pane_key('Up', 'k', 'SUPER|ALT'),
      util.bind_activate_pane_key('Down', 'j', 'SUPER|ALT'),
      util.bind_activate_pane_key('Left', 'h', 'SUPER|ALT'),
      util.bind_activate_pane_key('Right', 'l', 'SUPER|ALT'),

      -- Toggle pane zoom with super key
      {
        key = 'Enter',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.TogglePaneZoomState,
      },

      -- Toggle fullscreen with super+shift key
      {
        key = 'Enter',
        mods = 'SUPER',
        action = wezterm.action.ToggleFullScreen,
      },

      -- Rotate panes
      util.bind_rotate_pane_key('Clockwise', '.', 'SUPER'),
      util.bind_rotate_pane_key('CounterClockwise', '.', 'SUPER|CTRL'),

      -- Enable copy-to mode with `cmd-x`
      {
        key = 'x',
        mods = 'SUPER',
        action = wezterm.action.ActivateCopyMode,
      },
    }
  }
end

return M
