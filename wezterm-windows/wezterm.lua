local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local commands = require("commands")
local launcher = require("prog-launcher")


-- Font
config.font = wezterm.font('Dank Mono')
config.font_rules = {
  {
    italic = false,
    intensity = "Normal",
    font = wezterm.font_with_fallback({
      "Dank Mono",
      "Symbols Nerd Font Mono",
    }),
  },
}
config.font_size = 14
config.line_height = 1

-- Colors
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- Appearance
config.color_scheme = 'rose-pine'
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_and_split_indices_are_zero_based = false

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
config.default_prog = { "powershell.exe", "-NoLogo" }
config.launch_menu = launcher.launch_menu

-- Custom commands
wezterm.on("augment-command-palette", function()
  return commands
end)

-- tmux-style key bindings and setup
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab "DefaultDomain",
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}

for i = 0, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
  })
end

-- tmux status
wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a)     -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end   -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW }
  })
end)

-- and finally, return the configuration to wezterm
return config
