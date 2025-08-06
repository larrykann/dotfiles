local wezterm = require('wezterm')

local command = {
  brief = "Toggle terminal transparency",
  icon = "md_circle_opacity",
  action = wezterm.action_callback(function(window)
    local overrides = window:get_config_overrides() or {}
    
    if not overrides.window_background_opacity or overrides.window_background_opacity == 1 then
      overrides.window_background_opacity = 0.5
      overrides.win32_system_backdrop = "Acrylic"
      overrides.window_background_image = ""
    else
      overrides.window_background_opacity = 1.0

      -- For background images if you set them
      -- overrides.window_background_image = constants.bg_image
    end

    window:set_config_overrides(overrides)
  end),
}

return command
