#!/usr/bin/env bash

# Directorio de wallpapers
wallDIR="$HOME/Pictures/wallpapers"
iDIR="$HOME/.config/swaync/images" # Para notificaciones
# rofi_theme="$HOME/.config/rofi/config-wallpaper.rasi"
rofi_theme="$HOME/.config/mango/rofi/config-wallpaper.rasi"
# SCRIPTSDIR="$HOME/.config/river/scripts"
SCRIPTSDIR="$HOME/.config/mango/scripts"
# Configuración de transiciones de swww
FPS=60
TYPE="any"
DURATION=2
STEP=60
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-step $STEP"

# Detectar monitor activo
focused_monitor=$(wlr-randr | grep -w "current" | awk '{print $NF}' | sed "s/\.//")
if [[ -z "$focused_monitor" ]]; then
  notify-send -i "$iDIR/error.png" "Error" "No se detectó el monitor activo"
  exit 1
fi

# Calcular tamaño del ícono para rofi
scale_factor=$(wlr-randr | grep -w "current" | awk '{print $1}' | cut -d'x' -f1)
monitor_height=$(wlr-randr | grep -w "current" | awk '{print $NF}' | sed "s/\.//")
if ! command -v bc &>/dev/null; then
  notify-send -i "$iDIR/error.png" "Falta bc" "Instala el paquete bc primero"
  exit 1
fi
icon_size=$(echo "scale=1; ($monitor_height * 3) / ($scale_factor * 150)" | bc)
adjusted_icon_size=$(echo "$icon_size" | awk '{if ($1 < 15) $1 = 20; if ($1 > 25) $1 = 25; print $1}')
rofi_override="element-icon{size:${adjusted_icon_size}%;}"

# Obtener lista de imágenes (excluyendo videos)
mapfile -d '' PICS < <(find -L "${wallDIR}" -maxdepth 1 -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
  -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" \) -print0)

# Función para generar el menú de rofi
menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    if [[ "$pic_name" =~ \.gif$ ]]; then
      k cache_gif_image="$HOME/.cache/gif_preview/${pic_name}.png"
      if [[ ! -f "$cache_gif_image" ]]; then
        mkdir -p "$HOME/.cache/gif_preview"
        magick "$pic_path[0]" -resize 1920x1080 "$cache_gif_image"
      fi
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$cache_gif_image"
    else
      printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
    fi
  done
}

# Función principal
main() {
  # Matar instancias previas de rofi
  if pidof rofi >/dev/null; then
    pkill rofi
  fi

  # Mostrar menú rofi y obtener selección
  choice=$(menu | rofi -i -show -dmenu -config "$rofi_theme" -theme-str "$rofi_override" | xargs)

  if [[ -z "$choice" ]]; then
    echo "No se seleccionó ninguna imagen. Saliendo."
    exit 0
  fi

  # Random choice case
  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    swww img -o "$focused_monitor" "$RANDOM_PIC" $SWWW_PARAMS
    sleep 2
    "$SCRIPTSDIR/WallustSwww.sh"
    sleep 0.5
    exit 0
  fi

  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
    swww img -o "$focused_monitor" "${PICS[$pic_index]}" $SWWW_PARAMS
  else
    echo "Image not found."
    exit 1
  fi
  # Buscar el archivo seleccionado
  choice_basename=$(basename "$choice" | sed 's/\(.*\)\.[^.]*$/\1/')
  selected_file=$(find "$wallDIR" -maxdepth 1 -iname "$choice_basename.*" -print -quit)

  if [[ -z "$selected_file" ]]; then
    notify-send -i "$iDIR/error.png" "Error" "No se encontró la imagen seleccionada"
    exit 1
  fi

  wait $!
  "$SCRIPTSDIR/WallustSwww.sh" &&
    wait $!
  sleep 2
  # Matar daemons de fondo previos
  swww kill 2>/dev/null
  if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon --format xrgb &
  fi

  # Aplicar la imagen seleccionada
  cp "$selected_file" ~/.config/wall.png &&
    swww img "$selected_file" $SWWW_PARAMS &&
    wallust run "$selected_file" -s &
  # hellwal -i "$selected_file" --neon-mode &
}

main
sleep 1
notify-send 'Change image to '$choice_basename
sleep 2
pkill waybar
waybar -c ~/.config/mango/waybar/config -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &
