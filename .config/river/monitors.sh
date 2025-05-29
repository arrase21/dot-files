#!/bin/bash

restartWallpaper() {
  pkill swww-daemon
  disown
  swww-daemon --format xrgb
}

if [ $(uname -n) != "overlord" ]; then
  restartWallpaper
  exit 0
fi

# Initialize state variables
single_monitor_active=false
dual_monitor_active=false
delay=1

while true; do
  if [ $(wlr-randr | grep HDMI-A-1 | wc -l) -gt 0 ]; then
    if [ "$dual_monitor_active" = false ]; then
      # Switch to dual-monitor setup
      wlr-randr \
        --output eDP-1 --mode 1366x768 \
        --pos 0,0 --adaptive-sync
      wlr-randr \
        --output HDMI-A-1 --mode 1366x768 \
        --pos 1366,768 --transform normal
      # Update state
      dual_monitor_active=true
      single_monitor_active=false
      restartWallpaper
    fi
  else
    if [ "$single_monitor_active" = false ]; then
      # Switch to single-monitor setup
      wlr-randr \
        --output eDP-1 --mode 1366x766 --pos 0,0 --adaptive-sync disabled

      # Update state
      single_monitor_active=true
      dual_monitor_active=false
      restartWallpaper
    fi
  fi
  sleep $delay
done
