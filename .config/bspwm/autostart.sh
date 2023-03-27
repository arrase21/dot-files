#!/bin/bash

declare -a loop=(xbanish dunst)
for i in "${loop[@]}"; do
	pgrep -x "$i" | xargs kill
  $i &
done

if [[ ! $(pidof stalonetray) ]]; then
  pkill eww &
  stalonetray &
  xdo hide -n stalonetray
  polybar-msg action "#systray.hook.1"
  touch "/tmp/syshide.lock"
fi

# Compositor
killall picom 
while pgrep picom > /dev/null;
do
    sleep 0.1
done;
picom &
# Set wallpapper
nitrogen --restore &

startup &

# fix pointer
xsetroot -cursor_name left_ptr &

# Cache lockscreen 
mantablockscreen -i ~/.config/rice_assets/Images/lockscreen.png&

# Authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1&


# Enable power management
# xfce4-power-manager &

# Start copyq
copyq --start-server &

# Reached end of script
pkill -9 -f "dunst"
dunstify -i window_list "Successfully restarted BSPWM"
dunst > /dev/null 2> /dev/null &
thunar --daemon&
killall sxhkd
sxhkd -c ~/.config/sxhkd/sxhkdrc > /dev/null 2> /dev/null&


# Window event monitoring
killall winevents.sh
~/.bscripts/winevents.sh&

# Autosuspend
killall idle.sh
pgrep idle.sh || ~/.bscripts/idle.sh > /dev/null 2> /dev/null&


polybar -q bar1 -c ~/.config/polybar/config.ini &
polybar -q bar2 -c ~/.config/polybar/config.ini & 
polybar -q bar3 -c ~/.config/polybar/config.ini & 

polybar -q bar1_external -c ~/.config/polybar/config.ini &
polybar -q bar2_external -c ~/.config/polybar/config.ini &
polybar -q bar5_external -c ~/.config/polybar/config.ini &
