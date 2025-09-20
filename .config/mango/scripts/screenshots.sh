#!/usr/bin/env sh

if [ -z "$XDG_PICTURES_DIR" ]; then
  XDG_PICTURES_DIR="$HOME/Pictures"
fi

scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh" 2>/dev/null
swpy_dir="${confDir:-$HOME/.config}/swappy"
save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p "$save_dir"
mkdir -p "$swpy_dir"
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >"$swpy_dir/config"

function print_error {
  cat <<"EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p  : print all screens
        s  : snip area
        sf : snip area (frozen)
        m  : print focused output (if supported)
EOF
}


case $1 in
p)
  grim "$temp_screenshot" && swappy -f "$temp_screenshot" && screenshot_success=true
  ;;

s)
  selection=$(slurp)
  if [ -n "$selection" ]; then
    grim -g "$selection" "$temp_screenshot" && swappy -f "$temp_screenshot" && screenshot_success=true
  fi
  ;;

sf)
  grim /tmp/frozen.png
  selection=$(slurp)
  if [ -n "$selection" ]; then
    grim -g "$selection" "$temp_screenshot" && swappy -f "$temp_screenshot" && screenshot_success=true
  fi
  rm -f /tmp/frozen.png
  ;;

m)
  output=$(wlr-randr | grep '\*' | awk '{print $1}')
  if [ -n "$output" ]; then
    grim -o "$output" "$temp_screenshot" && swappy -f "$temp_screenshot" && screenshot_success=true
  fi
  ;;
*)
  print_error
  ;;
esac

if [ -f "${save_dir}/${save_file}" ]; then
  notify-send -a "t1" -i "${save_dir}/${save_file}" "saved in ${save_dir}"
  $HOME/.local/bin/Sounds.sh --screenshot
fi
