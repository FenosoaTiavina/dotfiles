#!/usr/bin/env bash

# Check if the system is Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "This script is intended for Arch Linux systems only."
    exit 0
fi

#---
## Helper Functions

# Checks if a package is installed
pkg_installed() {
    pacman -Qq "$1" &>/dev/null
}

# Gets the first available AUR helper from a predefined list
get_aur_helper() {
    local helpers=("paru" "yay")
    for helper in "${helpers[@]}"; do
        if pkg_installed "$helper"; then
            echo "$helper"
            return
        fi
    done
    echo ""
}

#---
## Script Logic

# Source variables
aurhlpr=$(get_aur_helper)
fpk_exup="flatpak update"

# Trigger a system upgrade
if [ "$1" == "up" ]; then
    if [ -z "$aurhlpr" ]; then
        echo "No AUR helper found. Please install paru or yay to use this feature."
        exit 1
    fi
    trap 'pkill -RTMIN+20 eww' EXIT
    command="
    read -n 1 -p 'Press any key to continue...';
    "
    # fastfetch;
    # $0 upgrade;
    # ${aurhlpr} -Syu;
    # $fpk_exup;

    ~/.local/bin/ghostty -e "echo ${command}"
    exit 0
fi

# Check for official and AUR updates
ofc=$( (while pgrep -x checkupdates > /dev/null; do sleep 1; done); checkupdates | wc -l)
aur=0
if [ -n "$aurhlpr" ]; then
    aur=$(${aurhlpr} -Qua | wc -l)
fi

# Check for Flatpak updates
if pkg_installed flatpak; then
    fpk=$(flatpak remote-ls --updates | wc -l)
    fpk_disp="\n󰏓 Flatpak $fpk"
else
    fpk=0
    fpk_disp=""
fi

# Calculate total available updates
upd=$(( ofc + aur + fpk ))

# Display package counts for the 'upgrade' action
if [ "${1}" == "upgrade" ]; then
    printf "[Official] %-10s\n[AUR]      %-10s\n[Flatpak]  %-10s\n" "$ofc" "$aur" "$fpk"
    exit 0
fi

# Show tooltip output for eww or similar tools
if [ "$upd" -eq 0 ]; then
    upd="󰮯" # If zero, display icon only
    echo "{\"text\":\"$upd\", \"tooltip\":[\" Packages are up to date\"]}"
else
    echo "{\"text\":\"󰮯 $upd\", \"tooltip\":[\"󱓽 Official $ofc\",\"󱓾 AUR $aur$fpk_disp\"]}"
fi
