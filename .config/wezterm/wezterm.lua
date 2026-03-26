return require("config").make({
  font = {
    family = "Maple Mono",
    size = 14,
    -- weight = "Medium",
    line_height = 1.2,
    cell_width = 1,
    ligatures = true,
  },
  background = {
    opacity = 0.95,
    blur = 20,
  },
  colors = {
    -- dark_appearance = true,
  },
  inactive_pane_brightness = 0.75,
  -- Set to false so we have everything running in background :)
  native_fullscreen_mode = true,
  always_show_tab_bar = false,
})
