#!/usr/bin/env bash
#This script requires imagemagick, please add it via systempkgs

# Set some variables
WALL_DIR="${HOME}/.config/hypr/pics/"
CACHE_DIR="${HOME}/.cache/rofi_icons/"
TRACKING_FILE="$HOME/Pictures/Screenshots/Variables/wallpaper_tracking.txt"

# Calculate monitor resolution and icon size the way wallpaper-launcher.sh does it
physical_monitor_size=24
monitor_res=$(hyprctl monitors | grep -A2 Monitor | head -n 2 | awk '{print $1}' | grep -oE '^[0-9]+')
dotsperinch=$(echo "scale=2; $monitor_res / $physical_monitor_size" | bc | xargs printf "%.0f")
# Adjust the divisor to make the icons smaller - changed from original calculation
monitor_res=$(( $monitor_res * $physical_monitor_size / $dotsperinch / 2 ))

# Set rofi command with x11 flag that works in wallpaper-launcher.sh
# Added height and width settings to make dialog more compact
rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;} window{width:80%;height:75%;} listview{lines:4;columns:4;}"
ROFI_EXECUTE="rofi -x11 -dmenu -theme ${HOME}/.config/rofi//wallselect.rasi -theme-str ${rofi_override}"

# Create cache dir if not exists
if [ ! -d "${CACHE_DIR}" ]; then
  mkdir -p "${CACHE_DIR}"
fi

# Convert images in directory and save to cache dir - reduced size from 500x500 to 300x300
for imagen in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$imagen" ] || continue
  nombre_archivo=$(basename "$imagen")
  [ -f "${CACHE_DIR}/${nombre_archivo}" ] || magick "$imagen" -resize 300x300^ -gravity center -extent 300x300 "${CACHE_DIR}/${nombre_archivo}"
done

# Launch rofi using the working approach without brackets
SELECTION=$(find "${WALL_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A; do 
  echo -en "$A\x00icon\x1f""${CACHE_DIR}"/"$A\n"
done | $ROFI_EXECUTE -i)

# Get basename directly since we're not using brackets anymore
BASENAME=$(basename "$SELECTION")

if [[ -n "$SELECTION" ]]; then
  # Set wallpaper
  swww query || swww init

  # Change the wallpaper using swww with the specified transition parameters
  swww img "${WALL_DIR}${BASENAME}" --transition-bezier .43,1.19,1,.4 --transition-fps 144 --transition-type grow --transition-duration 2 --transition-pos 0.680,0.970

  # Save the current wallpaper name
  echo "$BASENAME" >"$TRACKING_FILE"

  # Update the rofi config with the new wallpaper
  IMAGE1="background-image: url(\"${WALL_DIR}${BASENAME}\",width);"
  sed -i "s#background-image:.*#${IMAGE1}#" "$HOME/.config/rofi/themes/menu.rasi"

  IMAGE2="image=${WALL_DIR}${BASENAME}"
  sed -i "s#^image=.*#${IMAGE2}#" "$HOME/.config/hypr/swaylock/config"
else
  echo "No selection made in Rofi."
fi
