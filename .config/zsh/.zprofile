if [ -z "$DISPLAY" ] && [[ "$(tty)" == /dev/tty* ]]; then
    exec hyprland
fi
