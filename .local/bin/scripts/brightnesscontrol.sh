#!/usr/bin/env bash

scrDir=$(dirname "$(realpath "$0")")

# Check if SwayOSD is installed
use_swayosd=false
isNotify=${BRIGHTNESS_NOTIFY:-true}
if command -v swayosd-client >/dev/null 2>&1 && pgrep -x swayosd-server >/dev/null; then
    use_swayosd=true
fi

print_error() {
    local cmd
    cmd=$(basename "$0")
    cat <<EOF
    "${cmd}" <action> [step]
    ...valid actions are...
        i -- <i>ncrease brightness [+5%]
        d -- <d>ecrease brightness [-5%]

    Example:
        "${cmd}" i 10    # Increase brightness by 10%
        "${cmd}" d       # Decrease brightness by default step (5%)
EOF
}

send_notification() {
    brightness=$(brightnessctl info | grep -oP "(?<=\()\d+(?=%)" | cat)
    brightinfo=$(brightnessctl info | awk -F "'" '/Device/ {print $2}')
    # shellcheck disable=SC2154
    ico=display-brightness-symbolic.svg
    if [ "$brightness" -gt 75 ]; then
        ico="display-brightness-high-symbolic.svg"
    elif [ "$brightness" -gt 50 ]; then
        ico="display-brightness-medium-symbolic.svg"
    elif [ "$brightness" -gt 25 ]; then
        ico="display-brightness-low-symbolic.svg"
    else
        ico="display-brightness-off-symbolic.svg"
    fi
    bar=$(seq -s "⣿" $((brightness / 5)) | sed 's/[0-9]//g')
    [[ "${isNotify}" == true ]] && notify-send -a "Brightness" -r 7 -t 800 -i ~/.icons/Colloid-Green-Dark/status/symbolic/${ico} "${bar} ${brightness}" "${brightinfo} ${brightness}"
}

get_brightness() {
    brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
}

step=${BRIGHTNESS_STEPS:-5}
step="${2:-$step}"

case $1 in
i | -i) # increase the backlight
    if [[ $(get_brightness) -lt 10 ]]; then
        # increase the backlight by 1% if less than 10%
        step=1
    fi

    $use_swayosd && swayosd-client --brightness raise "$step" && exit 0
    brightnessctl set +"${step}"%
    send_notification
    ;;
d | -d) # decrease the backlight

    if [[ $(get_brightness) -le 10 ]]; then
        # decrease the backlight by 1% if less than 10%
        step=1
    fi

    if [[ $(get_brightness) -le 1 ]]; then
        brightnessctl set "${step}"%
        $use_swayosd && exit 0
    else
        $use_swayosd && swayosd-client --brightness lower "$step" && exit 0
        brightnessctl set "${step}"%-
    fi

    send_notification
    ;;
*) # print error
    print_error ;;
esac
