#!/usr/bin/env bash
CONFIG="$HOME/.config/hypr/hyprland.conf"

# Check if line is commented
if grep -qE '^\s*#\s*kb_options\s*=\s*compose:ralt' "$CONFIG"; then
    # Uncomment it
    sed -i 's/^\(\s*\)# \(kb_options\s*=\s*compose:ralt\)/\1\2/' "$CONFIG"
    notify-send -r 12 -t 3000 -i ~/.icons/Colloid-Green-Dark/actions/symbolic/ornament-check-symbolic.svg "Compose key" "enable"
    hyprctl reload
else
    # Comment it
    sed -i 's/^\(\s*\)\(kb_options\s*=\s*compose:ralt\)/\1# \2/' "$CONFIG"
    notify-send -r 12 -t 3000 -i ~/.icons/Colloid-Green-Dark/actions/symbolic/cross-small-symbolic.svg "Compose key" "Disable"
    hyprctl reload
fi


