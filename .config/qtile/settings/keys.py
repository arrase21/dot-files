# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile keybindings

from libqtile.config import Key
from libqtile.command import lazy


mod = "mod4"
mod1 = "mod1"

keys = [
    Key(key[0], key[1], *key[2:])
    for key in [
        # ------------ Window Configs ------------
        # Switch between windows in current stack pane
        ([mod], "j", lazy.layout.down()),
        ([mod], "k", lazy.layout.up()),
        ([mod], "h", lazy.layout.left()),
        ([mod], "l", lazy.layout.right()),
        # Change window sizes (MonadTall)
        ([mod, "shift"], "l", lazy.layout.grow()),
        ([mod, "shift"], "h", lazy.layout.shrink()),
        # Toggle floating
        ([mod, "shift"], "f", lazy.window.toggle_floating()),
        ([mod], "f", lazy.window.toggle_fullscreen()),
        # Move windows up or down in current stack
        ([mod, "shift"], "j", lazy.layout.shuffle_down()),
        ([mod, "shift"], "k", lazy.layout.shuffle_up()),
        ([mod, "shift"], "h", lazy.layout.shuffle_left()),
        ([mod, "shift"], "l", lazy.layout.shuffle_right()),
        # Toggle between different layouts as defined below
        # ([mod], "Tab", lazy.next_layout()),
        # ([mod, "shift"], "Tab", lazy.prev_layout()),
        # Kill window
        ([mod], "q", lazy.window.kill()),
        # Switch focus of monitors
        ([mod], "Tab", lazy.next_screen()),
        ([mod], "comma", lazy.prev_screen()),
        # Restajt Qtile
        ([mod, "control"], "r", lazy.restart()),
        # ([mod, "control"], "q", lazy.shutdown()),
        ([mod], "r", lazy.spawncmd()),
        # ------------ App Configs ------------
        # Eww
        ([mod], "d", lazy.spawn("/home/arrase/.local/bin/dashboard ")),
        (
            [mod],
            "n",
            lazy.spawn("/home/arrase/.config/eww/scripts/openNotificationCenter.sh"),
        ),
        (
            [mod],
            "c",
            lazy.spawn("/home/arrase/.config/eww/scripts/openControlCenter.sh"),
        ),
        # Menu
        ([mod], "F1", lazy.spawn("/home/arrase/.config/rofi/alternative/bin/launcher")),
        ([mod], "a", lazy.spawn("def-nmdmenu")),
        ([mod], "x", lazy.spawn("/home/arrase/.config/rofi/alternative/bin/powermenu")),
        # Browser
        ([mod], "w", lazy.spawn("opera")),
        # File Explorer
        ([mod], "e", lazy.spawn("thunar")),
        # Screenshot
        ([], "Print", lazy.spawn("/home/arrase/.bscripts/ss.sh")),
        # Terminal
        ([mod], "Return", lazy.spawn("wezterm")),
        # Telegram
        ([mod], "t", lazy.spawn("telegram-desktop")),
        ([mod, "shift"], "r", lazy.spawn("redshift -x")),
        # ------------ Hardware Configs ------------
        # Volume
        ([], "XF86AudioMute", lazy.spawn("/home/arrase/.bscripts/volume.sh mute")),
        (
            [],
            "XF86AudioLowerVolume",
            lazy.spawn("/home/arrase/.bscripts/volume.sh down"),
        ),
        ([], "XF86AudioRaiseVolume", lazy.spawn("/home/arrase/.bscripts/volume.sh up")),
        # Brightness
        (
            [],
            "XF86MonBrightnessUp",
            lazy.spawn("/home/arrase/.bscripts/brightness.sh up"),
        ),
        (
            [],
            "XF86MonBrightnessDown",
            lazy.spawn("/home/arrase/.bscripts/brightness.sh down"),
        ),
    ]
]
