#!/usr/bin/env bash

# Portrait dimensions (width x height)
PORTRAIT_WIDTH=540
PORTRAIT_HEIGHT=1020

# Landscape dimensions (width x height)
LANDSCAPE_WIDTH=1820
LANDSCAPE_HEIGHT=1020
WAYDROID_HYPR_CONFIG="$HOME/dotfiles/.config/hypr/rules/waydroid.conf"

scrDir="$(dirname "$(realpath "$0")")"
confDir="${confDir}/config"

waydroid_style="${ROFI_WAYDROID_STYLE:-waydroid_mode}"

# execute rofi with common parameters
run_rofi() {
    local placeholder="$1"
    shift

    rofi -dmenu \
        -theme-str "entry { placeholder: \"${placeholder}\";}" \
        -theme "${waydroid_style}" \
        "$@"
}

setup_rofi_config() {
    # font scale
    local font_scale="${ROFI_CLIPHIST_SCALE}"
    [[ "${font_scale}" =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}

    # set rofi font override
    font_override="* {font: \"${font_name:-"JetBrainsMono Nerd Font"} ${font_scale}\";}"

    # border settings
    local hypr_border=${hypr_border:-"$(hyprctl -j getoption decoration:rounding | jq '.int')"}
    local wind_border=$((hypr_border * 3 / 2))
    local elem_border=$((hypr_border == 0 ? 5 : hypr_border))

    # rofi position
    rofi_position=$(get_rofi_pos)

    # border width
    local hypr_width=${hypr_width:-"$(hyprctl -j getoption general:border_size | jq '.int')"}
    r_override="window{border:${hypr_width}px;border-radius:${wind_border}px;}wallbox{border-radius:${elem_border}px;} element{border-radius:${elem_border}px;}"
}

# Check if config file exists
check_config() {
    if [ ! -f "$WAYDROID_HYPR_CONFIG" ]; then
        echo "Error: Hyprland config file not found at $WAYDROID_HYPR_CONFIG"
        exit 1
    fi
    
    # Create backup if it doesn't exist
    if [ ! -f "${WAYDROID_HYPR_CONFIG}.backup" ]; then
        echo "Creating backup of config file..."
        cp "$WAYDROID_HYPR_CONFIG" "${WAYDROID_HYPR_CONFIG}.backup"
    fi
}

set_portrait_rules() {
    echo "Switching to portrait mode by editing the config file."
    check_config
    
    sed -E \
        -e "s/^(windowrulev2 = size) [0-9]+ [0-9]+,class:\^\(.\*\[Ww\]aydroid\).\*/\1 $PORTRAIT_WIDTH $PORTRAIT_HEIGHT,class:^(.*[Ww]aydroid).*/g" \
        -e "s/^(windowrulev2 = minsize) [0-9]+ [0-9]+,class:\^\(.\*\[Ww\]aydroid\).\*/\1 $PORTRAIT_WIDTH $PORTRAIT_HEIGHT,class:^(.*[Ww]aydroid).*/g" \
        -e "s/^(windowrulev2 = maxsize) [0-9]+ [0-9]+,class:\^\(.\*\[Ww\]aydroid\).\*/\1 $PORTRAIT_WIDTH $PORTRAIT_HEIGHT,class:^(.*[Ww]aydroid).*/g" \
        "$WAYDROID_HYPR_CONFIG" > "${WAYDROID_HYPR_CONFIG}.tmp"
    
    if [ $? -eq 0 ] && [ -s "${WAYDROID_HYPR_CONFIG}.tmp" ]; then
        mv "${WAYDROID_HYPR_CONFIG}.tmp" "$WAYDROID_HYPR_CONFIG"
        echo "Config file updated successfully."
        
        # Reload Hyprland config
        if command -v hyprctl >/dev/null 2>&1; then
            hyprctl reload
            echo "Hyprland config reloaded."
        else
            echo "Warning: hyprctl not found, please reload Hyprland manually."
        fi
        
        # Send notification
        if command -v notify-send >/dev/null 2>&1; then
            notify-send "Waydroid" "Portrait rules applied and config reloaded."
        fi
    else
        echo "Error: Failed to update config file"
        rm -f "${WAYDROID_HYPR_CONFIG}.tmp"
        exit 1
    fi
}

set_landscape_rules() {
    echo "Switching to landscape mode by editing the config file."
    check_config
    
    sed -E \
        -e "s/^(windowrulev2 = size) [0-9]+ [0-9]+,class:\^\(.\*\[Ww\]aydroid\).\*/\1 $LANDSCAPE_WIDTH $LANDSCAPE_HEIGHT,class:^(.*[Ww]aydroid).*/g" \
        -e "s/^(windowrulev2 = minsize) [0-9]+ [0-9]+,class:\^\(.\*\[Ww\]aydroid\).\*/\1 $LANDSCAPE_WIDTH $LANDSCAPE_HEIGHT,class:^(.*[Ww]aydroid).*/g" \
        -e "s/^(windowrulev2 = maxsize) [0-9]+ [0-9]+,class:\^\(.\*\[Ww\]aydroid\).\*/\1 $LANDSCAPE_WIDTH $LANDSCAPE_HEIGHT,class:^(.*[Ww]aydroid).*/g" \
        "$WAYDROID_HYPR_CONFIG" > "${WAYDROID_HYPR_CONFIG}.tmp"
    
    if [ $? -eq 0 ] && [ -s "${WAYDROID_HYPR_CONFIG}.tmp" ]; then
        mv "${WAYDROID_HYPR_CONFIG}.tmp" "$WAYDROID_HYPR_CONFIG"
        echo "Config file updated successfully."
        
        # Reload Hyprland config
        if command -v hyprctl >/dev/null 2>&1; then
            hyprctl reload
            echo "Hyprland config reloaded."
        else
            echo "Warning: hyprctl not found, please reload Hyprland manually."
        fi
        
        # Send notification
        if command -v notify-send >/dev/null 2>&1; then
            notify-send "Waydroid" "Landscape rules applied and config reloaded."
        fi
    else
        echo "Error: Failed to update config file"
        rm -f "${WAYDROID_HYPR_CONFIG}.tmp"
        exit 1
    fi
}

# Function to restore original config
restore_config() {
    if [ -f "${WAYDROID_HYPR_CONFIG}.backup" ]; then
        echo "Restoring original config..."
        cp "${WAYDROID_HYPR_CONFIG}.backup" "$WAYDROID_HYPR_CONFIG"
        if command -v hyprctl >/dev/null 2>&1; then
            hyprctl reload
        fi
        echo "Config restored."
    else
        echo "No backup found."
    fi
}

main() {
  setup_rofi_config
  echo "Current Waydroid rules in config:"
  grep "class:^([Ww]aydroid.*)" "$WAYDROID_HYPR_CONFIG"

  selected_item=$( (
    echo -e "Portrait"
    echo -e "Landscape"
    echo -e "Restore"
  ) | run_rofi " Waydroid display mode..." -multi-select -i -display-columns 1)
  case "$selected_item" in
    "Portrait")
        set_portrait_rules
        ;;
    "Landscape")
        set_landscape_rules
        ;;
    "Restore")
        restore_config
        ;;
    *)
  esac

  waydroid session stop

}

# run main function
main "$@"
