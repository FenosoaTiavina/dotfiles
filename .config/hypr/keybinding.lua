local term      = "ghostty"
local editor    = term .. "-e nvim"
local file      = "thunar"
local browser   = "zen-browser"
local launcher  = "vicinae toggle"
local wallpaper = "vicinae 'vicinae://extensions/sovereign/awww-switcher/wpgrid'"
local clipboard = "vicinae 'vicinae://extensions/vicinae/clipboard/history'"

local script    = "$HOME/.local/bin/scripts" -- set scripts path
local super     = "SUPER"                    -- super / meta / windows key

hl.bind(super .. "+ T", hl.dsp.exec_cmd(term), { description = "Open terminap - " .. term })
hl.bind(super .. "+ E", hl.dsp.exec_cmd(file), { description = "Open file manager - " .. file })
hl.bind(super .. "+ C", hl.dsp.exec_cmd(editor), { description = "Open editor" })
hl.bind(super .. "+ B", hl.dsp.exec_cmd(browser), { description = "Open browser - " .. browser })
hl.bind(super .. "+ SPACE", hl.dsp.exec_cmd(launcher), { description = "App launcher - " .. launcher })
hl.bind(super .. "+ V", hl.dsp.exec_cmd(clipboard), { description = "Clipboard" })
hl.bind(super .. "+ SHIFT + W", hl.dsp.exec_cmd(wallpaper), { description = "Wallpaper selectow" })

-- # Window/Session actions
hl.bind(super .. "+ Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind(super .. "+ W", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating window" })
hl.bind(super .. "+ RETURN", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
    { description = "Maximize window" })
hl.bind(super .. "+ SHIFT + RETURN", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
    { description = "Fullscreen window" })
hl.bind(super .. " + ALT + L", hl.dsp.exec_cmd("hyprlock & sleep 1"), { description = "Lock" })
hl.bind(super .. "+ SHIFT + F", hl.dsp.window.pin(), { description = "Pin window" })

hl.bind(super .. "+ G", hl.dsp.group.toggle(), { description = "Group toggle" })
hl.bind(super .. "+ CTRL + H", hl.dsp.group.next(), { description = "Group next" })
hl.bind(super .. "+ CTRL + L", hl.dsp.group.prev(), { description = "Group previous" })



-- Audio control
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -i m"),
    { locked = true, description = "Microphone volume mute" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o m"),
    { locked = true, description = "Audio volume mute" })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o i"),
    { locked = true, repeating = true, description = "Audio volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o d"),
    { locked = true, repeating = true, description = "Audio volume down" })
-- brightness control
hl.bind("XF86MonBrightnessUp  ", hl.dsp.exec_cmd(script .. "/brightnesscontrol.sh i"),
    { locked = true, repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(script .. "/brightnesscontrol.sh d"),
    { locked = true, repeating = true, description = "Brightness down" })


-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Media play" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause i"), { locked = true, description = "Media pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Media next" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Media previous" })

-- Screenshots
hl.bind(super .. " + P", hl.dsp.exec_cmd("hyprshot -m output"), { description = "Screenshot monitor" })
hl.bind(super .. " + CTRL + P", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Screenshot window" })
hl.bind(super .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region"), { description = "Screenshot region" })



-- window
hl.bind(super .. " + H", hl.dsp.focus({ direction = "l" }), { description = "Focus window LEFT" })
hl.bind(super .. " + L", hl.dsp.focus({ direction = "r" }), { description = "Focus window RIGHT" })
hl.bind(super .. " + K", hl.dsp.focus({ direction = "u" }), { description = "Focus window UP" })
hl.bind(super .. " + J", hl.dsp.focus({ direction = "d" }), { description = "Focus window DOWN" })

-- hl.bind(super .. " + SHIFT + H", hl.dsp.window.resize({ x = "05", y = "00" }), { repeating = true, description = "" })
-- hl.bind(super .. " + SHIFT + L", hl.dsp.window.resize({ x = "-5", y = "00" }), { repeating = true, description = "" })
-- hl.bind(super .. " + SHIFT + K", hl.dsp.window.resize({ x = "00", y = "-5" }), { repeating = true, description = "" })
-- hl.bind(super .. " + SHIFT + J", hl.dsp.window.resize({ x = "00", y = "05" }), { repeating = true, description = "" })


hl.bind(super .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind(super .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })


hl.bind(super .. " + Tab", hl.dsp.layout("cyclenext"), { description = "Next window" })
hl.bind(super .. " + SHIFT + Tab", hl.dsp.layout("cycleprev"), { description = "Previous window" })
hl.bind(super .. " + ALT + Tab", hl.dsp.layout("swapwithmaster"), { description = "Swap active window with master" })
hl.bind(super .. " + CTRL + ALT + SHIFT + C", function()
    if hl.get_config("input.kb_options") == "compose:ralt" then
        hl.config {
            input = {
                kb_options = ""
            }
        }
        hl.exec_cmd(
            "notify-send -r 12 -t 3000 -i ~/.themes/Colloid-Green-Dark-Compact/actions/symbolic/cross-small-symbolic.svg 'Compose key' 'Disabled'")
    else
        hl.config {
            input = {
                kb_options = "compose:ralt"
            }
        }
        hl.exec_cmd(
            "notify-send -r 12 -t 3000 -i ~/.themes/Colloid-Green-Dark-Compact/actions/symbolic/ornament-check-symbolic.svg 'Compose key' 'Enabled'")
    end
end, { description = "Toggle compose key" })


-- workspace
hl.bind(super .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }), { description = "Move to active workspace -1" })
hl.bind(super .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }), { description = "Move to active workspace +1" })

hl.bind(super .. " + CTRL + LEFT", hl.dsp.focus({ workspace = "r-1" }), { description = "Move to workspace -1" })
hl.bind(super .. " + CTRL + RIGHT", hl.dsp.focus({ workspace = "r+1" }), { description = "Move to workspace +1" })

hl.bind(super .. " + S", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle special workspace" })
hl.bind(super .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }),
    { description = "Send active window to special workspace" })

local function workspace_binds(i)
    hl.bind(super .. " + " .. i, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
    hl.bind(super .. " + ALT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }),
        { description = "Send to workspace " .. i })
    hl.bind(super .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = true }),
        { description = "Send & follow to workspace " .. i })
end
for i = 0, 9 do
    workspace_binds(i)
end
