#!/bin/bash
# Define the path to the swww cache directory
cache_dir="$HOME/.cache/swww/"

# Get current monitor from swww (first listed)
current_monitor=$(swww query | grep -m1 "Output" | awk '{print $2}')
echo "Current monitor: $current_monitor"

# Construct the full path to the cache file
cache_file="$cache_dir$current_monitor"
echo "Cache file: $cache_file"

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Check if the cache file exists for the current monitor output
if [ -f "$cache_file" ]; then
  # Get the wallpaper path from the cache file (first non-empty line)
  wallpaper_path=$(grep -v 'Lanczos3' "$cache_file" | head -n 1)
  echo "Wallpaper path: $wallpaper_path"

  # symlink the wallpaper to the location Rofi can access
  if ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"; then
    ln_success=true
  fi

  # copy the wallpaper for wallpaper effects
  cp -r "$wallpaper_path" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
fi

# Run wallust if successful
if [ "$ln_success" = true ]; then
  echo 'Executing wallust'
  wallust run "$wallpaper_path" -s &
fi
