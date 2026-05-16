local monitor_scale = "1";
local script = "$HOME/.local/bin/scripts" -- set scripts path

hl.monitor({ output = "eDP-1", mode = "highres@highrr", position = "auto", scale = monitor_scale })
hl.monitor({ output = "DP-1", mode = "highres@highrr", position = "auto-up", scale = monitor_scale })
hl.monitor({ output = "", mode = "highres@highrr", position = "auto", scale = monitor_scale })

-- workspace
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })

-- autostart
hl.on("hyprland.start", function()
    hl.exec_cmd(script .. "/resetxdgportal.sh")                                                     -- reset XDPH for screenshare
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")                               -- for XDPH
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")          -- for XDPH
    hl.exec_cmd(script .. "/polkitkdeauth.sh")                                                      -- authentication dialogue for GUI apps
    hl.exec_cmd("udiskie --automount --smart-tray")                                                 -- front-end that allows to manage removable media
    hl.exec_cmd("blueman-applet")                                                                   --
    hl.exec_cmd("hypridle")                                                                         --
    hl.exec_cmd("awww-daemon")                                                                      --
    hl.exec_cmd("vicinae server")                                                                   --
end)

-- env
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("HYPRSHOT_DIR", "$HOME/Pictures/screenshots")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", 1)
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", 1)
hl.env("MOZ_ENABLE_WAYLAND", 1)
hl.env("GDK_SCALE", monitor_scale)


-- layout
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
    master = {
        new_status = "inherit"
    }
})

-- input
hl.config {
    input = {
        kb_layout          = "us",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "compose:ralt",
        kb_rules           = "",

        follow_mouse       = 1,

        sensitivity        = 0, -- -1.0 - 1.0, 0 means no modification.
        force_no_accel     = 1,
        numlock_by_default = true,
        touchpad           = {
            natural_scroll = true,
        },
    }
}


hl.device {
    name = "Razer DeathAdder Essential",
    sensitivity = -0.5,
}

require("theme")
require("keybinding")
require("windowrules")
require("hook")
