local wezterm = require("wezterm")

local launch_menu = {}

-- Only add launch menu entries for Windows MSVC targets
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

    -- PowerShell Entry
    table.insert(launch_menu, {
        label = 'PowerShell',
        args = { 'powershell.exe', '-NoLogo' },
    })

    -- Command Prompt Entry
    table.insert(launch_menu, {
        label = 'Command Prompt',
        args = { 'cmd.exe' },
    })
end

return {
    launch_menu = launch_menu,
}


