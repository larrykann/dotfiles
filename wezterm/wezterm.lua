local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local commands = require("commands")
local launcher = require("prog-launcher")


-- Font
config.font = wezterm.font('Dank Mono')
config.font_size = 16
config.line_height = 1

-- Colors
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- Appearance
config.color_scheme = 'Tokyo Night'
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- For performance?
config.max_fps = 120
config.prefer_egl = true

-- Default Shell and Launcher Settings
config.default_prog = { 'powershell.exe' }
config.launch_menu = launcher.launch_menu

-- Custom commands
wezterm.on("augment-command-palette", function()
  return commands
end)

-- and finally, return the configuration to wezterm
return config
