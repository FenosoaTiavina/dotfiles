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
hl.bind(mainMod .. "+ G", hl.dsp.group.toggle())
hl.bind(mainMod .. "+ W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+ RETURN", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. "+ SHIFT + RETURN", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. "+ L", hl.dsp.exec_cmd("hyprlock & sleep 1"))
hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.exec_cmd(script .. "/windowpin.sh"))


-- Audio control
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -i m"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o d"), { locked = true, release = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(script .. "/volumecontrol.sh -o i"), { locked = true, release = true })

-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause i"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. " + Tab", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.layout("cycleprev"))


-- workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + CTRL + RIGHT ", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + LEFT  ", hl.dsp.focus({ workspace = "r+1" }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "0" }))
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }))

hl.bind(mainMod .. " + ALT + 0", hl.dsp.window.move({ workspace = "0", follow= false}))
hl.bind(mainMod .. " + ALT + 1", hl.dsp.window.move({ workspace = "1", follow= false}))
hl.bind(mainMod .. " + ALT + 2", hl.dsp.window.move({ workspace = "2", follow= false}))
hl.bind(mainMod .. " + ALT + 3", hl.dsp.window.move({ workspace = "3", follow= false}))
hl.bind(mainMod .. " + ALT + 4", hl.dsp.window.move({ workspace = "4", follow= false}))
hl.bind(mainMod .. " + ALT + 5", hl.dsp.window.move({ workspace = "5", follow= false}))
hl.bind(mainMod .. " + ALT + 6", hl.dsp.window.move({ workspace = "6", follow= false}))
hl.bind(mainMod .. " + ALT + 7", hl.dsp.window.move({ workspace = "7", follow= false}))
hl.bind(mainMod .. " + ALT + 8", hl.dsp.window.move({ workspace = "8", follow= false}))
hl.bind(mainMod .. " + ALT + 9", hl.dsp.window.move({ workspace = "9", follow= false}))

hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "0", follow= true}))
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1", follow= true}))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2", follow= true}))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3", follow= true}))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4", follow= true}))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5", follow= true}))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6", follow= true}))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7", follow= true}))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8", follow= true}))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9", follow= true}))

