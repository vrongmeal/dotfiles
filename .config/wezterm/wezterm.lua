return require("config").make({
  font = {
    family = "CommitMono",
    size = 12.5,
    line_height = 1.35,
    cell_width = 1.00,
    ligatures = true,
  },
  background = {
    opacity = 0.95,
    blur = 20,
  },
  -- Set to false so we have everything running in background :)
  native_fullscreen_mode = false,
  always_show_tab_bar = true,
})
