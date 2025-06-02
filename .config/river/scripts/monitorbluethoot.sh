#!/bin/bash

bluetoothctl monitor | grep --line-buffered "Connected: yes\|Connected: no" |
  while read -r line; do
    if echo "$line" | grep -q "Connected: yes"; then
      notify-send "Bluetooth conectado"
    elif echo "$line" | grep -q "Connected: no"; then
      notify-send "Bluetooth desconectado"
    fi
  done
