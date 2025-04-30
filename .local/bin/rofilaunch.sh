#!/usr/bin/env sh

#// set variables

scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/globalcontrol.sh"
roconf="${confDir}/rofi/themes/style_${rofiStyle}.rasi"

[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10

if [ ! -f "${roconf}" ]; then
  roconf="$(find "${confDir}/rofi/themes" -type f -name "style_*.rasi" | sort -t '_' -k 2 -n | head -1)"
fi

#// rofi action

case "${1}" in
d | --drun) r_mode="drun" ;;
w | --window) r_mode="window" ;;
f | --filebrowser) r_mode="filebrowser" ;;
h | --help)
  echo -e "$(basename "${0}") [action]"
  echo "d :  drun mode"
  echo "w :  window mode"
  echo "f :  filebrowser mode,"
  exit 0
  ;;
*) r_mode="drun" ;;
esac

rofi -show "${r_mode}" -theme "${roconf}"
