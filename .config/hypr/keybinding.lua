local TERM      = "ghostty"
local editor    = TERM .. "-e nvim"
local file      = "thunar"
local browser   = "zen-browser"
local launcher  = "vicinae toggle"
local wallpaper = "vicinae 'vicinae://extensions/sovereign/awww-switcher/wpgrid'"
local clipboard = "vicinae 'vicinae://extensions/vicinae/clipboard/history'"

local script    = "$HOME/.local/bin/scripts" -- set scripts path

local mainMod   = "SUPER"                    -- super / meta / windows key

hl.bind(mainMod .. "+ T", hl.dsp.exec_cmd(TERM))
hl.bind(mainMod .. "+ E", hl.dsp.exec_cmd(file))
hl.bind(mainMod .. "+ C", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. "+ B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. "+ SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. "+ V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. "+ SHIFT + W", hl.dsp.exec_cmd(wallpaper))

-- # Window/Session actions
-- bindd = $mainMod+Shift, P,Color Picker , exec, hyprpicker -a                # Pick color (Hex) >> clipboard#
hl.bind(mainMod .. "+ Q", hl.dsp.window.close())
hl.bind(mainMod .. "+ W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+ RETURN", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. "+ SHIFT + RETURN", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock & sleep 1"))
hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.exec_cmd(script .. "/windowpin.sh"))

hl.bind(mainMod .. "+ G", hl.dsp.group.toggle())
hl.bind(mainMod .. "+ CTRL + L", hl.dsp.group.prev())
hl.bind(mainMod .. "+ CTRL + H", hl.dsp.group.next())



-- Audio control
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -i m"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o i"), { locked = true, repeating = true })
-- brightness control
hl.bind("XF86MonBrightnessUp  ", hl.dsp.exec_cmd(script .. "/brightnesscontrol.sh i"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(script .. "/brightnesscontrol.sh d"),
    { locked = true, repeating = true })


-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause i"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m output"))

hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("hyprshot -m window"))

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region"))



-- window
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = 5, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = -5, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -5 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 5 }), { repeating = true })


hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


hl.bind(mainMod .. " + Tab", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + ALT + Tab", hl.dsp.layout("swapwithmaster"))


-- workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.focus({ workspace = "r+1" }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

local function workspace_binds(i)
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + ALT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = true }))
end
for i = 0, 9 do
    workspace_binds(i)
end
