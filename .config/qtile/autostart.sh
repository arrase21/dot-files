#!/bin/sh

# systray battery icon
# cbatticon -u 5 &
# systray volume
# volumeicon &

declare -a loop=(xbanish dunst)
for i in "${loop[@]}"; do
	pgrep -x "$i" | xargs kill
  $i &
done

# if [[ ! $(pidof stalonetray) ]]; then
#   pkill eww &
#   stalonetray &
#   xdo hide -n stalonetray
#   touch "/tmp/syshide.lock"
# fi

# Compositor
killall picom 
picom &
# killall eww
# eww &
# Set wallpapper
# nitrogen --restore &

# startup &

# fix pointer
# xsetroot -cursor_name left_ptr &

# Cache lockscreen 
# mantablockscreen -i ~/.config/rice_assets/Images/lockscreen.png&

# Authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1&


# Start copyq
# copyq --start-server &

# Reached end of script
pkill -9 -f "dunst"
# dunstify -i window_list "Successfully restarted BSPWM"
dunst > /dev/null 2> /dev/null &
# thunar --daemon&


# Window event monitoring
# killall winevents.sh
# ~/.bscripts/winevents.sh&

# Autosuspend
killall idle.sh
pgrep idle.sh || ~/.bscripts/idle.sh > /dev/null 2> /dev/null&
