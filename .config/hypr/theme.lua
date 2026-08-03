local GTK_THEME = "Colloid-Green-Dark-Compact";
local ICON_THEME = "Colloid-Green-Dark";
local CURSOR_THEME = "Bibata-Modern-Classic";
local COLOR_SCHEME = "prefer-dark";
local COLOR_SIZE = 20;

hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme " .. ICON_THEME);
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme " .. GTK_THEME);
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme " .. COLOR_SCHEME);
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface font-name             " .. 'JetBrainsMono Nerd Font Mono 12');
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface document-font-name    " .. 'JetBrainsMono Nerd Font Mono 12');
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name   " .. 'JetBrainsMono Nerd Font Mono 12');
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface font-antialiasing     " .. 'rgba');
hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface font-hinting          " .. 'full');
hl.dsp.exec_cmd("hyprctl setcursor $CURSOR_THEME " .. CURSOR_THEME);

-- look and feel
hl.config({
    general = {
        gaps_in          = 2,
        gaps_out         = 2,
        border_size      = 0,
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "master",
    },

    decoration = {
        rounding = 0,


        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = false,
    },
})
