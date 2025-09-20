#!/bin/bash

# Ruta al archivo con la paleta original
palette="$HOME/.config/foot/colors-original"

# Verifica que el archivo existe
if [[ ! -f "$palette" ]]; then
  notify-send "foot reset" "Paleta no encontrada en $palette"
  exit 1
fi

# Aplica la paleta con footclient
footclient control set-colors "$palette" &&
  notify-send "foot reset" "Colores de foot restaurados"
