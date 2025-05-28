#!/bin/bash

IFS=$'\n\t'

# === Variables ===
scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/globalcontrol.sh"
rofi_theme_dir="${confDir}/rofi/themes"
rofi_config_file="$HOME/.config/rofi/config.rasi"
rofiConf="${confDir}/rofi/selector.rasi"
rofiAssetDir="${confDir}/rofi/assets"
SED=$(which sed)

[[ "${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
r_scale="configuration {font: \"JetBrainsMono Nerd Font ${rofiScale}\";}"
elem_border=$((hypr_border * 5))
icon_border=$((elem_border - 5))

# === Monitor scale ===
mon_x_res=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
mon_scale=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .scale' | sed "s/\.//")
mon_x_res=$((mon_x_res * 100 / mon_scale))

elm_width=$(((20 + 12 + 16) * rofiScale))
max_avail=$((mon_x_res - (4 * rofiScale)))
col_count=$((max_avail / elm_width))
[[ "${col_count}" -gt 5 ]] && col_count=5

r_override="window{width:100%;} listview{columns:${col_count};} element{orientation:vertical;border-radius:${elem_border}px;} element-icon{border-radius:${icon_border}px;size:20em;} element-text{enabled:false;}"

# === Mostrar menú con íconos ===
RofiSel=$(ls "${rofi_theme_dir}"/style_*.rasi 2>/dev/null | awk -F '[_.]' '{print $((NF - 1))}' | while read styleNum; do
  echo -en "${styleNum}\x00icon\x1f${rofiAssetDir}/style_${styleNum}.png\n"
done | sort -n | rofi -dmenu -theme-str "${r_override}" -config "${rofiConf}" -select "${rofiStyle}")

# === Aplicar tema seleccionado ===
if [[ -n "${RofiSel}" ]]; then
  theme_name="style_${RofiSel}.rasi"
  theme_path="${rofi_theme_dir}/${theme_name}"

  # Convertir ruta a ~ si es necesario
  if [[ "$theme_path" == $HOME/* ]]; then
    theme_path_with_tilde="~${theme_path#$HOME}"
  else
    theme_path_with_tilde="$theme_path"
  fi

  # Añadir o actualizar línea @theme
  if ! grep -q '^\s*@theme' "$rofi_config_file"; then
    echo -e "\n\n@theme \"$theme_path_with_tilde\"" >>"$rofi_config_file"
    echo "Added @theme \"$theme_path_with_tilde\" to $rofi_config_file"
  else
    $SED -i "s/^\(\s*@theme.*\)/\/\/\1/" "$rofi_config_file"
    echo -e "@theme \"$theme_path_with_tilde\"" >>"$rofi_config_file"
    echo "Updated @theme line to $theme_path_with_tilde"
  fi

  # Limitar cantidad de //@theme líneas
  max_line=9
  total_lines=$(grep -c '^\s*\/\/@theme' "$rofi_config_file")
  if [ "$total_lines" -gt "$max_line" ]; then
    excess=$((total_lines - max_line))
    for i in $(seq 1 "$excess"); do
      $SED -i '0,/^\s*\/\/@theme/ { /^\s*\/\/@theme/ {d; q; }}' "$rofi_config_file"
    done
  fi

  # Notificación
  notify-send -a "rofi-theme" -r 91190 -t 2200 -i "${rofiAssetDir}/style_${RofiSel}.png" "Rofi Theme aplicado" "$theme_name"
fi

# Cerrar Rofi si está abierto
if pgrep -x "rofi" >/dev/null; then
  pkill rofi
fi
