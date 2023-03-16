#!/bin/bash


bspc config border_width 3
bspc config window_gap 10
bspc config split_ratio 0.50
bspc config top_padding 5
bspc config bottom_padding  0

bspc config focused_border_color "#7bc5e4"
bspc config normal_border_color "#32344a"
bspc config active_border_color "#444b6a"

bspc config borderless_monocle true
bspc config gapless_monocle true
# bspc config paddingless_monocle true
bspc config single_monocle false
bspc config focus_follows_pointer true

bspc config pointer_modifier mod4
bspc config pointer_action1 move
bspc config pointer_action2 resize_side
bspc config pointer_action3 resize_corner

bspc config merge_overlapping_monitors true
bspc config remove_unplugged_monitors true
bspc config remove_disabled_monitors true
