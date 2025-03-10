#!/bin/bash

#
# Workspace specific conditions
#

# floating windows
declare -a floats=(Alafloat Lxappearance Arandr
	Viewnior feh Nm-connection-editor Matplotlib
	Yad Gnome-disks SimpleScreenRecorder
	Font-manager Gnome-system-monitor Thunar
	PureRef Gcolor3 flameshot Xarchiver Blueberry.py
	Pavucontrol jamesdsp Nvidia-settings Nitrogen
	Peazip Xfce4-appearance-settings Xfce4-mouse-settings
	parsecd Galculator com.github.joseexposito.touche
	XVkbd usbguard-applet-qt telegram-desktop 
  Mumble qimgv Peek Tk pyqt6)
for i in "${floats[@]}"; do
	bspc rule -a "$i" manage=on state=floating follow=on focus=on center=true
done

#
# Exclusive apps
#

# Keep plank above all windows
bspc rule -a Plank manage=off locked=on border=off state=floating focus=off

#
# Exclusive conditions
#

# Force tile windows
declare -a tiled=(Zathura)
for i in "${tiled[@]}"; do
	bspc rule -a "$i" manage=on state=tiled
done

# Force full screen windows
declare -a fullscreen=(vlc)
for i in "${fullscreen[@]}"; do
	bspc rule -a "$i" manage=on state=fullscreen
done

bspc rule --add opera               rectangle=1130x768+395+140
bspc rule --add Polkit-gnome-authentication-agent-1 rectangle=810x280+555+399
bspc rule --add Rofi						manage=off
bspc rule --add Pavucontrol					state=floating rectangle=610x610+650+235
bspc rule --add Thunar						rectangle=650x500+635+290
