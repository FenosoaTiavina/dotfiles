#!/usr/bin/env bash


WAYDROID_CLASS="Waydroid"

# --- Define Dimensions ---
# Portrait dimensions (width x height)
PORTRAIT_WIDTH=540
PORTRAIT_HEIGHT=820

# Landscape dimensions (width x height)
LANDSCAPE_WIDTH=1500
LANDSCAPE_HEIGHT=820
WAYDROID_HYPR_CONFIG="$HOME/dotfiles/.config/hypr/rules/waydroid.conf"

scrDir="$(dirname "$(realpath "$0")")"
confDir="${confDir}/config"
# shellcheck source=/dev/null
. "${scrDir}/globalcontrol.sh"


font_override="* {font: \"${font_name:-"JetBrainsMono Nerd Font"} ${font_scale}\";}"

i_override="$(get_hyprConf "ICON_THEME")"
i_override="configuration {icon-theme: \"${i_override}\";}"

waydroid_style="${ROFI_WAYDROID_STYLE:-waydroid_mode}"

# execute rofi with common parameters
run_rofi() {
    local placeholder="$1"
    shift

    rofi -dmenu \
        -theme-str "entry { placeholder: \"${placeholder}\";}" \
        -theme-str "${font_override}" \
        -theme-str "${r_override}" \
        -theme-str "${rofi_position}" \
        -theme "${waydroid_style}" \
        "$@"
}

setup_rofi_config() {
    # font scale
    local font_scale="${ROFI_CLIPHIST_SCALE}"
    [[ "${font_scale}" =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}

    # set font name
    local font_name=${ROFI_CLIPHIST_FONT:-$ROFI_FONT}
    font_name=${font_name:-$(get_hyprConf "MENU_FONT")}
    font_name=${font_name:-$(get_hyprConf "FONT")}

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


# setup rofi configuration
set_portrait_rules() {
    echo "Switching to portrait mode by editing the config file."
    
    awk -v pw="$PORTRAIT_WIDTH" -v ph="$PORTRAIT_HEIGHT" '
    /windowrulev2 = size.*class:\^?\(Waydroid\)/ {
        print "windowrulev2 = size " pw " " ph ",class:^(Waydroid)"
        next
    }
    /windowrulev2 = minsize.*class:\^?\(Waydroid\)/ {
        print "windowrulev2 = minsize " pw " " ph ",class:^(Waydroid)"
        next
    }
    /windowrulev2 = maxsize.*class:\^?\(Waydroid\)/ {
        print "windowrulev2 = maxsize " pw " " ph ",class:^(Waydroid)"
        next
    }
    { print }
    ' "$WAYDROID_HYPR_CONFIG" > "${WAYDROID_HYPR_CONFIG}.tmp" && mv "${WAYDROID_HYPR_CONFIG}.tmp" "$WAYDROID_HYPR_CONFIG"
    
    hyprctl reload
    notify-send "waydroid" "Portrait rules applied and config reloaded."
}

set_landscape_rules() {
    echo "Switching to landscape mode by editing the config file."
    
    awk -v lw="$LANDSCAPE_WIDTH" -v lh="$LANDSCAPE_HEIGHT" '
    /windowrulev2 = size.*class:\^?\(Waydroid\)/ {
        print "windowrulev2 = size " lw " " lh ",class:^(Waydroid)"
        next
    }
    /windowrulev2 = minsize.*class:\^?\(Waydroid\)/ {
        print "windowrulev2 = minsize " lw " " lh ",class:^(Waydroid)"
        next
    }
    /windowrulev2 = maxsize.*class:\^?\(Waydroid\)/ {
        print "windowrulev2 = maxsize " lw " " lh ",class:^(Waydroid)"
        next
    }
    { print }
    ' "$WAYDROID_HYPR_CONFIG" > "${WAYDROID_HYPR_CONFIG}.tmp" && mv "${WAYDROID_HYPR_CONFIG}.tmp" "$WAYDROID_HYPR_CONFIG"
    
    hyprctl reload
    notify-send "waydroid" "Landscape rules applied and config reloaded."
}

main() {
  setup_rofi_config
  echo "Current Waydroid rules in config:"
  grep "class:^(Waydroid)" "$WAYDROID_HYPR_CONFIG"

  selected_item=$( (
    echo -e "Portrait"
    echo -e "Landscape"
  ) | run_rofi " Waydroid display mode..." -multi-select -i -display-columns 1)
  case "$selected_item" in
    "Portrait")
        set_portrait_rules
        ;;
    "Landscape")
        set_landscape_rules
        ;;
    *)
  esac

  waydroid session stop

}

# run main function
main "$@"
