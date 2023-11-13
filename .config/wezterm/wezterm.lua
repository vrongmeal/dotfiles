local wt = require 'wezterm'

local function kb_split_pane(direction, key, mods)
  return {
    mods   = mods,
    key    = key,
    action = wt.action.SplitPane {
      direction = direction,
      size      = { Percent = 50 },
    },
  }
end

local function kb_activate_pane(direction, key, mods)
  return {
    mods   = mods,
    key    = key,
    action = wt.action.ActivatePaneDirection(direction),
  }
end

local function kb_rotate_panes(direction, key, mods)
  return {
    mods = mods,
    key = key,
    action = wt.action.RotatePanes(direction),
  }
end

local function is_dark_appearance()
  if wt.gui then
    local app = wt.gui.get_appearance()
    if app:find 'Dark' then
      return true
    else
      return false
    end
  end

  -- Default to 'true' if cannot figure out.
  return false
end

local function colors()
  if is_dark_appearance() then
    return {
      color_scheme = "Seti",
      split        = "#04B431",
      cursor_fg    = 'black',
    }
  else
    return {
      color_scheme = "Cupertino (base16)",
      split        = "#04B431",
      cursor_fg    = 'white',
    }
  end
end

local colors = colors()

-- Set the value of zoom.
--
-- Zoom is set as a percentage (out of 100). This basically adjusts the value of
-- font size (which is almost everything in the terminal).
local zoom = 102

local function gen_font(name, size, lh, cw)
  return {
    font        = wt.font(name),
    font_size   = size * (zoom / 100),
    line_height = lh,
    cell_width  = cw,
  }
end

local font_ubuntu_mono      = gen_font('Ubuntu Mono',      14.5, 1.2,  1)
local font_agave            = gen_font('Agave',            14,   1.2,  1.05)
local font_source_code_pro  = gen_font('Source Code Pro',  12.7, 1.1,  0.95)
local font_jetbrains_mono   = gen_font('JetBrains Mono',   12.5, 1.1,  1)
local font_fragment_mono    = gen_font('Fragment Mono',    13,   1.1,  1)
local font_sf_mono          = gen_font('SF Mono',          12,   1.2,  1)
local font_andale_mono      = gen_font('Andale Mono',      14,   1.1,  1)
local font_hack             = gen_font('Hack',             12,   1.2,  1.05)
local font_zed_mono         = gen_font('Zed Mono',         13,   1.05, 1.2)
local font_spot_mono        = gen_font('Spot Mono',        13.5, 1,    0.9)
local font_menlo            = gen_font('Menlo',            12.5, 1.2,  1)
local font_cousine          = gen_font('Cousine',          12.5, 1.25, 1)
local font_spline_sans_mono = gen_font('Spline Sans Mono', 12,   1.2,  1.05)
local font_commit_mono      = gen_font('CommitMono',       12.5, 1.2,  1)
local font_intelone_mono    = gen_font('IntelOne Mono',    12,   1,    1)
local font_monoid           = gen_font('Monoid',           11,   1,    1.1)
local font_monaco           = gen_font('Monaco',           11.7, 1.15, 1.05)
-- Github Monaspace Fonts
local font_monaspace_argon   = gen_font('Monaspace Argon',   12.5, 1.2, 1)
local font_monaspace_krypton = gen_font('Monaspace Krypton', 12.5, 1.2, 1)
local font_monaspace_neon    = gen_font('Monaspace Neon',    12.5, 1.2, 1)
local font_monaspace_radon   = gen_font('Monaspace Radon',   12.5, 1.2, 1)
local font_monaspace_xenon   = gen_font('Monaspace Xenon',   12.5, 1.2, 1)

-- Set this to any font-table value as defined above
local font = font_monaco

return {
  -- Font settings
  font        = font.font,
  font_size   = font.font_size,
  line_height = font.line_height,
  cell_width  = font.cell_width,
 
  native_macos_fullscreen_mode = true,
  hide_tab_bar_if_only_one_tab = true,

  -- Disable font ligatures
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  -- Color settings (based on background)
  color_scheme = colors.color_scheme,
  colors       = {
    split      = colors.split,
    cursor_fg  = colors.cursor_fg,
  },

  window_background_image_hsb = {
    brightness = 0.025,
    hue        = 1.0,
    saturation = 1.0,
  },

  window_padding = {
    left   = '0.5cell',
    right  = '0.5cell',
    top    = '0.1cell',
    bottom = '0.1cell',
  },

  -- Dim the lights when switching panes
  inactive_pane_hsb = {
    hue        = 1,
    saturation = 0.75,
    brightness = 0.75, 
  },

  -- Control cursor animation (don't like the slow blinking)
  default_cursor_style = 'BlinkingBlock',
  animation_fps        = 1,
  cursor_blink_rate    = 700,

  -- TODO: Configure background for the terminal
  keys = {
    -- Split pane keys
    kb_split_pane('Left',  'l', 'SUPER'),
    kb_split_pane('Right', 'r', 'SUPER'),
    kb_split_pane('Down',  'd', 'SUPER'),
    kb_split_pane('Up',    'u', 'SUPER'),

    -- Switch/Activate another pane
    kb_activate_pane('Up',    'UpArrow',    'SUPER|ALT'),
    kb_activate_pane('Down',  'DownArrow',  'SUPER|ALT'),
    kb_activate_pane('Left',  'LeftArrow',  'SUPER|ALT'),
    kb_activate_pane('Right', 'RightArrow', 'SUPER|ALT'),

    -- Toggle pane zoom with super key
    {
      key    = 'Enter',
      mods   = 'SUPER',
      action = wt.action.TogglePaneZoomState,
    },

    -- Rotate panes
    kb_rotate_panes('Clockwise',        '.', 'SUPER'),
    kb_rotate_panes('CounterClockwise', '.', 'SUPER|CTRL'),
  },
}
