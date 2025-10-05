#!/usr/bin/env bash

# ---------------------------
# Configuration
# ---------------------------
WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
WALLPAPER_CUSTOM_PATHS=()
CACHE_DIR="$HOME/.cache/wallpaper"
wallSet="$CACHE_DIR/wall.set"

ROFI_THEME="$HOME/.config/rofi/selector.rasi"

# Ensure cache dirs exist
mkdir -p "$CACHE_DIR/thumbs"
mkdir -p "$CACHE_DIR/dcols"

# ---------------------------
# Functions
# ---------------------------

# Generate hashmap arrays wallList[] and wallHash[]
get_hashmap() {
    wallList=()
    wallHash=()
    for path in "$@"; do
        if [ -d "$path" ]; then
            while IFS= read -r -d '' file; do
                wallList+=("$file")
                wallHash+=("$(echo -n "$file" | sha1sum | awk '{print $1}')")
            done < <(find "$path" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.bmp" -o -iname "*.tiff" \) -print0)
        fi
    done
}

# Build JSON describing wallpapers (without generating thumbs yet)
Wall_Json() {
    [ ! -d "${WALLPAPERS_DIR}" ] && echo "ERROR: \"${WALLPAPERS_DIR}\" does not exist" && exit 0
    wallPathArray=("${WALLPAPERS_DIR}")
    wallPathArray+=("${WALLPAPER_CUSTOM_PATHS[@]}")

    get_hashmap "${wallPathArray[@]}"

    wallListJson=$(printf '%s\n' "${wallList[@]}" | jq -R . | jq -s .)
    wallHashJson=$(printf '%s\n' "${wallHash[@]}" | jq -R . | jq -s .)

    # Corrected jq command
    jq -n --argjson wallList "$wallListJson" --argjson wallHash "$wallHashJson" --arg cacheHome "${CACHE_DIR}" '
        [range(0; $wallList | length) as $i | 
            {
                path: $wallList[$i], 
                hash: $wallHash[$i], 
                basename: ($wallList[$i] | split("/") | last),
                thmb: "\($cacheHome)/thumbs/\($wallHash[$i]).thmb",
                sqre: "\($cacheHome)/thumbs/\($wallHash[$i]).sqre"
            }
        ] | .[] | .rofi_sqre = ( .basename + ":::" + .path + ":::" + .sqre + "\u0000icon\u001f" + .sqre)
    ' | jq -s .
}

# Generate thumbnail (only when wallpaper applied)
generate_thumbnail() {
    local img="$1"
    local hash="$2"
    local thumb_path="$CACHE_DIR/thumbs/${hash}.sqre"

    # Skip if already exists
    [ -f "$thumb_path" ] && return

    if command -v convert >/dev/null 2>&1; then
        convert "$img" -thumbnail 512x512^ -gravity center -extent 512x512 "$thumb_path" 2>/dev/null
    elif command -v ffmpeg >/dev/null 2>&1; then
        ffmpeg -i "$img" -vf "scale=512:512:force_original_aspect_ratio=decrease,pad=512:512:(ow-iw)/2:(oh-ih)/2" "$thumb_path" -y 2>/dev/null
    fi
}

# Rofi selector
Wall_Select() {
    font_scale="${ROFI_WALLPAPER_SCALE}"
    [[ "${font_scale}" =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}

    font_name=${ROFI_WALLPAPER_FONT:-$ROFI_FONT}
    font_name=${font_name:-"JetBrainsMono Nerd Font"}
    font_override="* {font: \"${font_name} ${font_scale}\";}"

    elem_border=3

    mon_data=$(hyprctl -j monitors 2>/dev/null || echo "[]")
    mon_x_res=$(jq '.[] | select(.focused==true) | if (.transform % 2 == 0) then .width else .height end' <<<"${mon_data}")
    mon_scale=$(jq '.[] | select(.focused==true) | .scale' <<<"${mon_data}" | sed "s/\.//")
    [ -z "$mon_x_res" ] && mon_x_res=1920
    [ -z "$mon_scale" ] && mon_scale=100
    mon_x_res=$((mon_x_res * 100 / mon_scale))

    elm_width=$(((28 + 8 + 5) * font_scale))
    max_avail=$((mon_x_res - (4 * font_scale)))
    col_count=$((max_avail / elm_width))

    r_override="
    window{width:100%;}
    element{
        orientation:vertical;
        children: [ element-icon, element-text];
    }
    element-icon{ size:512px; }
    element-text{ padding: 1em; }
    listview{ columns:${col_count}; spacing:5em; }
    "
    # Read the current wallpaper path from the cache file
    current_wallpaper_path="$(cat "$wallSet" 2>/dev/null)"
    
    # Check if a wallpaper is set
    if [ -f "$wallSet" ]; then
        current_wallpaper_basename="$(basename "$current_wallpaper_path")"
        rofi_select_string="${current_wallpaper_basename}:::${current_wallpaper_path}:::${CACHE_DIR}/thumbs"
    else
        rofi_select_string=""
    fi

    local entry
    entry=$(Wall_Json | jq -r '.[].rofi_sqre' | rofi -dmenu \
        -display-column-separator ":::" \
        -display-columns 1 \
        -theme-str "${font_override}" \
        -theme-str "${r_override}" \
        -theme "${ROFI_THEME}" \
        -select "$rofi_select_string")

    selected_thumbnail="$(awk -F ':::' '{print $3}' <<<"${entry}")"
    selected_wallpaper_path="$(awk -F ':::' '{print $2}' <<<"${entry}")"
    selected_wallpaper="$(awk -F ':::' '{print $1}' <<<"${entry}")"

    export selected_wallpaper selected_wallpaper_path selected_thumbnail

    if [ -z "${selected_wallpaper}" ]; then
        echo "No wallpaper selected"
        exit 0
    fi
}

# Apply wallpaper (generate thumb here)
set_wallpaper() {
    local img="$1"
    [ -f "$img" ] || return

    local hash
    hash=$(echo -n "$img" | sha1sum | awk '{print $1}')

    echo "$img" > "$wallSet"
    swww img "$img" --transition-type grow --transition-fps 60 --transition-duration 1

    generate_thumbnail "$img" "$hash"
}

# Pick random wallpaper
Wall_Random() {
    local walls=()
    mapfile -t walls < <(Wall_Json | jq -r '.[].path')
    [ ${#walls[@]} -eq 0 ] && echo "No wallpapers found" && exit 1
    local random_wall="${walls[RANDOM % ${#walls[@]}]}"
    set_wallpaper "$random_wall"
}

# ---------------------------
# Case Switch
# ---------------------------

case "$1" in
    select)
        Wall_Select
        set_wallpaper "$selected_wallpaper_path"
        ;;
    random)
        Wall_Random
        ;;
    list)
        Wall_Json
        ;;
    current)
        [ -f "$wallSet" ] && cat "$wallSet" || echo "No wallpaper set"
        ;;
    *)
        echo "Usage: $0 {select|random|list|current}"
        exit 1
        ;;
esac
