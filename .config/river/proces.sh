#!/bin/bash

# detects if system is my desktop PC or not

isoverlord=false

if [ "$(uname -n)" = "overlord" ]; then
  isoverlord=true
fi

# stop processes already running for hard restart
pkill waybar
pkill dunst
pkill swaync
pkill nm-applet
pkill swaybg
pkill swww-daemon
pkill swww
pkill swayidle
pkill polkit-gnome-au
# pkill fcitx5

# auto starting audio
# my chinese character typing provider
# fcitx5 -D &
# network indicator
nm-applet --indicator &
# foot --server &

riverctl spawn "wl-clipboard"
# authentication agent (GUI sudo)
rver/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
# script for my monitors if on desktop PC
$HOME/.config/river/monitors.sh &

if [ "$isoverlord" = true ]; then
  # status bar
  waybar -c $HOME/.config/waybar/config &

  # creates manipulated mono audio sink for my single speaker

else
  # if in my laptop, set idle lock time
  swayidle -w timeout 300 $HOME/.config/system_scripts/lock.sh &
  # status bar for laptop
  waybar -c $HOME/.config/waybar/config &
fi
