hl.window_rule({
    name = "windowrule-1",
    opaque = true,
    match = {
        class = "(.)",
    },
})
hl.window_rule({
    name = "windowrule-5",
    float = true,
    match = {
        class = "^(zen)$",
        title = "^(Picture-in-Picture)$",
    },
})
hl.window_rule({
    name = "windowrule-6",
    float = true,
    match = {
        class = "^(zen)$",
        title = "^(Library)$",
    },
})
hl.window_rule({
    name = "windowrule-7",
    float = true,
    match = {
        class = "^(com.mitchellh.ghostty)$",
        title = "^(top)$",
    },
})
hl.window_rule({
    name = "windowrule-8",
    float = true,
    match = {
        class = "^(com.mitchellh.ghostty)$",
        title = "^(btop)$",
    },
})
hl.window_rule({
    name = "windowrule-9",
    float = true,
    match = {
        class = "^(com.mitchellh.ghostty)$",
        title = "^(htop)$",
    },
})
hl.window_rule({
    name = "windowrule-10",
    float = true,
    match = {
        class = "^(vlc)$",
    },
})
hl.window_rule({
    name = "windowrule-12",
    float = true,
    match = {
        class = "^(qt5ct)$",
    },
})
hl.window_rule({
    name = "windowrule-13",
    float = true,
    match = {
        class = "^(qt6ct)$",
    },
})
hl.window_rule({
    name = "windowrule-14",
    float = true,
    match = {
        class = "^(nwg-look)$",
    },
})
hl.window_rule({
    name = "windowrule-15",
    float = true,
    match = {
        class = "^(org.kde.ark)$",
    },
})
hl.window_rule({
    name = "windowrule-16",
    float = true,
    match = {
        class = "^(org.pulseaudio.pavucontrol)$",
    },
})
hl.window_rule({
    name = "windowrule-17",
    float = true,
    match = {
        class = "^(blueman-manager)$",
    },
})
hl.window_rule({
    name = "windowrule-18",
    float = true,
    match = {
        class = "^(nm-applet)$",
    },
})
hl.window_rule({
    name = "windowrule-19",
    float = true,
    match = {
        class = "^(nm-connection-editor)$",
    },
})
hl.window_rule({
    name = "windowrule-20",
    float = true,
    match = {
        class = "^(org.kde.polkit-kde-authentication-agent-1)$",
    },
})
-- waydroid
hl.window_rule({
    name = "windowrule-1",
    tag = "+waydroid",
    match = {
        class = "^(.*[Ww]aydroid)",
    },
})
hl.window_rule({
    name = "windowrule-2",
    tag = "+waydroid",
    match = {
        class = "^(.*[Ww]lroots).*",
    },
})
-- Rule for any Waydroid window
hl.window_rule({
    name = "windowrule-4",
    workspace = "emptym",
    border_size = 0,
    match = {
        tag = "waydroid*",
    },
})
-- Rules for the Keymapper overlay
hl.window_rule({
    name = "keymap_rule",
    border_size = 1,
    workspace = "emptym",
    float = true,
    no_max_size = true,
    pseudo = false,
    match = {
        class = "^(.*WaydroidHelper\\.KeyMapper.*)",
    },
})

-- common modals
hl.window_rule({
    name = "windowrule-31",
    float = true,
    match = {
        title = "^(Open)$",
    },
})
hl.window_rule({
    name = "windowrule-32",
    float = true,
    match = {
        title = "^(Choose Files)$",
    },
})
hl.window_rule({
    name = "windowrule-33",
    float = true,
    match = {
        title = "^(Save As)$",
    },
})
hl.window_rule({
    name = "windowrule-34",
    float = true,
    match = {
        title = "^(Confirm to replace files)$",
    },
})
hl.window_rule({
    name = "windowrule-35",
    float = true,
    match = {
        title = "^(File Operation Progress)$",
    },
})
hl.window_rule({
    name = "windowrule-36",
    float = true,
    match = {
        class = "^(xdg-desktop-portal-gtk)$",
    },
})
