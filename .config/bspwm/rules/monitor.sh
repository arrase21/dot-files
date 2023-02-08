# !/bin/bash

# this script setups the monitors workspaces, setup
# correctly the environment variables to correct working

# env variables
# get with xrandr
# EXTERNAL_MONITOR_NAME="HDMI1" # e.g: Your monitor that are connected sometimes to your laptop
# ONLY_ONE_MONITOR_NAME="LVDS1" # e.g: Laptop monitor name
# MONITOR_ORDER="HDMI1 LVDS1" # blank to default order, defines the order of the workspaces for the monitors

# # getting the monitor
# connected_monitors=$(xrandr | grep -w 'connected' | cut -d ' ' -f 2 | wc -l)

# if [[ $connected_monitors > 1 ]]; then
#   monitor="$EXTERNAL_MONITOR_NAME"
# else
#   monitor="$ONLY_ONE_MONITOR_NAME"
# fi

# # assign the workspaces with bspc
# assign_workspaces () {
#   bspc monitor $monitor -d 1 2 3 4 5 6
#   if [[ $monitor == "$EXTERNAL_MONITOR_NAME" ]]; then
#     bspc monitor $ONLY_ONE_MONITOR_NAME -d 7 8 9
#   fi
#   if [[ $MONITOR_ORDER != "" ]]; then
#     bspc wm -O $MONITOR_ORDER
#   fi
# }

# assign_workspaces

INTERNAL_MONITOR="eDP1"
EXTERNAL_MONITOR="HDMI1"
# on first load setup default workspaces
if [[ "$1" = 0 ]]; then
  if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
    bspc monitor "$EXTERNAL_MONITOR" -d 1 2 3 4 5
    bspc monitor "$INTERNAL_MONITOR" -d 6 7 8 9 10
    bspc wm -O "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR"
  else
    bspc monitor "$INTERNAL_MONITOR" -d 1 2 3 4 5 6 7 8 9 10
  fi
fi
monitor_add() {
  # Move first 5 desktops to external monitor
  for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed 5q); do
    bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
  done

  # Remove default desktop created by bspwm
  bspc desktop Desktop --remove

  # reorder monitors
  bspc wm -O "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR"
}
monitor_remove() {
  # Add default temp desktop because a minimum of one desktop is required per monitor
  bspc monitor "$EXTERNAL_MONITOR" -a Desktop

  # Move all desktops except the last default desktop to internal monitor
  for desktop in $(bspc query -D -m "$EXTERNAL_MONITOR");	do
    bspc desktop "$desktop" --to-monitor "$INTERNAL_MONITOR"
  done

  # delete default desktops
  bspc desktop Desktop --remove

  # reorder desktops
  bspc monitor "$INTERNAL_MONITOR" -o 1 2 3 4 5 6 7 8 9 10
}
if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
  # set xrandr rules for docked setup
  xrandr --output "$INTERNAL_MONITOR" --mode 1366x768 --pos 0x0 --rotate normal --output "$EXTERNAL_MONITOR" --primary --mode 1360x768 --rotate normal
  if [[ $(bspc query -D -m "${EXTERNAL_MONITOR}" | wc -l) -ne 5 ]]; then
    monitor_add
  fi
  bspc wm -O "$EXTERNAL_MONITOR" "$INTERNAL_MONITOR"
else
  # set xrandr rules for mobile setup
  xrandr --output "$INTERNAL_MONITOR" --primary --mode 1366x768 --pos 0x0 --rotate normal --output "$EXTERNAL_MONITOR" --off
  if [[ $(bspc query -D -m "${INTERNAL_MONITOR}" | wc -l) -ne 10 ]]; then
    monitor_remove
  fi
fi
