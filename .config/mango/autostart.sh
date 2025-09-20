#!/bin/bash
# 自启动脚本 仅作参考

set +e
# obs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# notify
# swaync -c ~/.config/mango/swaync/config.json -s ~/.config/mango/swaync/style.css >/dev/null 2>&1 &
swaync &
# night light
# wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &

# wallpaper
# swaybg -i ~/.config/mango/wallpaper/czd.png >/dev/null 2>&1 &
swaybg -i ~/Pictures/wallpapers/Gengar-Cemetery.jpg >/dev/null 2>&1 &
# swaybg -i ~/.config/mango/wallpaper/czd.png >/dev/null 2>&1 &
# swww-daemon &
# top bar
waybar -c ~/.config/mango/waybar/config -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &

# xwayland dpi scale
# echo "Xft.dpi: 84" | xrdb -merge #dpi缩放
# xrdb merge ~/.Xresources >/dev/null 2>&1

# ime input
# fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
# wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager

wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
# bluetooth
# blueman-applet >/dev/null 2>&1 &

# network
# nm-applet --indicator &

# Permission authentication
/usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &

# inhibit by audio
# sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
# swayosd-server >/dev/null 2>&1 &
