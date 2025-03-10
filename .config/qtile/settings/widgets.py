from libqtile import widget
from .theme import colors
from libqtile.command import lazy

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


def base(fg="text", bg="dark"):
    return {"foreground": colors[fg], "background": colors[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg="text", bg="dark", fontsize=16, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=3)


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg), text=" ", fontsize=37, padding=-2  # Icon: nf-oct-triangle_left
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg="light"),
            font="Iosevka Nerd Font",
            fontsize=17,
            margin_y=2,
            margin_x=0,
            padding_y=5,
            padding_x=5,
            borderwidth=1,
            active=colors["active"],
            inactive=colors["inactive"],
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["urgent"],
            this_current_screen_border=colors["focus"],
            this_screen_border=colors["grey"],
            other_current_screen_border=colors["dark"],
            other_screen_border=colors["dark"],
            disable_drag=True,
        ),
        separator(),
        widget.WindowName(**base(fg="focus"), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),
    separator(),
    widget.Systray(background=colors["dark"], padding=5, font=20),
    powerline("color1"),
    widget.TextBox(
        **base(bg="color1", fg="dark"),
        font="Iosevka Nerd Font",
        fontsize=14,
        text="󱩑 ",
    ),
    widget.Backlight(
        **base(bg="color1", fg="dark"),
        backlight_name="intel_backlight",
        update_interval=0.2,
    ),
    powerline("color3", "color1"),
    widget.TextBox(
        **base(bg="color3", fg="dark"),
        font="Iosevka Nerd Font",
        fontsize=15,
        text=" ",
    ),
    widget.Battery(**base(bg="color3", fg="dark"), format="{percent:2.0%}"),
    powerline("color2", "color3"),
    widget.TextBox(
        **base(bg="color2"),
        text="墳",
        font="Iosevka Nerd Font",
        fontsize=15,
    ),
    widget.PulseVolume(
        **base(bg="color2"),
        limit_max_volume="True",
        fontsize=15,
        font="Iosevka Nerd Font",
    ),
    powerline("dark", "color2"),
    widget.Image(
        **base(bg="dark"),
        filename="~/.config/qtile/icons/skull-74-256.ico",
        mouse_callbacks={
            "Button1": lazy.spawn(
                "/home/arrase/.config/eww/scripts/openControlCenter.sh"
            )
        },
        fontsize=15,
    ),
    widget.Image(
        **base(bg="dark"),
        filename="~/.config/qtile/icons/message-icon-png-14918.png",
        mouse_callbacks={
            "Button1": lazy.spawn(
                "/home/arrase/.config/eww/scripts/openNotificationCenter.sh"
            )
        },
    ),
    powerline("active", "dark"),
    widget.TextBox(
        **base(bg="active"),
        font="Iosevka Nerd Font",
        fontsize=15,
        text=" ",
    ),
    widget.Clock(
        **base(bg="active"),
        font="Iosevka Nerd Font",
        format="%I:%M %p ",
        fontsize=15,
    ),
    powerline("dark", "active"),
    widget.QuickExit(
        **base(bg="dark", fg="color1"),
        # background="#242831",
        # foreground="#e06",
        font="Iosevka Nerd Font",
        default_text=" ⏻  ",
        fontsize=15,
    ),
    # widget.Systray(background=colors['dark'], padding=5),
    # *workspaces(),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Systray(
    #     background="#242831",
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Sep(
    #     linewidth=0,
    #     background="#292d3e",
    #     padding=5,
    #     size_percent=50,
    # ),
    # # mose_callbacks={'Button1': ('def-nmdmenu')}
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.TextBox(
    #     font="Iosevka Nerd Font",
    #     fontsize=15,
    #     text="  ",
    #     background="#242831",
    #     foreground="#ff92df",
    # ),
    # widget.Battery(background="#242831", foreground="#ff92df", format="{percent:2.0%}"),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Sep(
    #     linewidth=0,
    #     background="#292d3e",
    #     padding=5,
    #     size_percent=50,
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.TextBox(
    #     text="墳",
    #     foreground="#88c0d0",
    #     background="#242831",
    #     font="Iosevka Nerd Font",
    # ),
    # widget.PulseVolume(
    #     foreground="#88c0d0",
    #     background="#242831",
    #     limit_max_volume="True",
    #     # mouse_callbacks={"Button3": open_pavu},
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Sep(
    #     linewidth=0,
    #     background="#292d3e",
    #     padding=5,
    #     size_percent=50,
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Image(
    #     filename="~/.config/qtile/icons/skull-74-256.ico",
    #     mouse_callbacks={
    #         "Button1": lazy.spawn(
    #             "/home/arrase/.config/eww/scripts/openControlCenter.sh"
    #         )
    #     },
    #     background="#242831",
    #     fontsize=15,
    # ),
    # widget.Image(
    #     filename="~/.config/qtile/icons/message-icon-png-14918.png",
    #     mouse_callbacks={
    #         "Button1": lazy.spawn(
    #             "/home/arrase/.config/eww/scripts/openNotificationCenter.sh"
    #         )
    #     },
    #     fontsize=15,
    #     background="#242831",
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=20,
    #     padding=0,
    # ),
    # widget.Sep(
    #     linewidth=0,
    #     background="#292d3e",
    #     padding=5,
    #     size_percent=50,
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.TextBox(
    #     font="Iosevka Nerd Font",
    #     fontsize=15,
    #     text=" ",
    #     foreground="#50fa7b",
    #     background="#242831",
    # ),
    # widget.Clock(
    #     format="%I:%M %p ",
    #     background="#242831",
    #     foreground="#50fa7b",
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Sep(
    #     linewidth=0,
    #     background="#292d3e",
    #     padding=5,
    #     size_percent=50,
    # ),
    # widget.QuickExit(
    #     background="#242831",
    #     foreground="#e06",
    #     default_text=" ⏻  ",
    #     fontsize=20,
    # ),
]

secondary_widgets = [
    *workspaces(),
    # separator(),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.TextBox(
    #     text="墳",
    #     foreground="#88c0d0",
    #     background="#242831",
    #     font="Iosevka Nerd Font",
    # ),
    # widget.PulseVolume(
    #     foreground="#88c0d0",
    #     background="#242831",
    #     limit_max_volume="True",
    #     # mouse_callbacks={"Button3": open_pavu},
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.Sep(
    #     linewidth=0,
    #     background="#292d3e",
    #     padding=5,
    #     size_percent=50,
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    # widget.TextBox(
    #     font="Iosevka Nerd Font",
    #     fontsize=15,
    #     text=" ",
    #     foreground="#50fa7b",
    #     background="#242831",
    # ),
    # widget.Clock(
    #     format="%I:%M %p ",
    #     background="#242831",
    #     foreground="#50fa7b",
    # ),
    # widget.TextBox(
    #     text="",
    #     foreground="#242831",
    #     background="#2e3440",
    #     fontsize=28,
    #     padding=0,
    # ),
    *workspaces(),
    separator(),
    powerline("color3"),
    widget.TextBox(
        **base(bg="color3", fg="dark"),
        font="Iosevka Nerd Font",
        fontsize=15,
        text=" ",
    ),
    widget.Battery(**base(bg="color3", fg="dark"), format="{percent:2.0%}"),
    powerline("color2", "color3"),
    widget.TextBox(
        **base(bg="color2"),
        text="墳",
        font="Iosevka Nerd Font",
        fontsize=15,
    ),
    widget.PulseVolume(
        **base(bg="color2"),
        limit_max_volume="True",
        fontsize=15,
        font="Iosevka Nerd Font",
    ),
    powerline("dark", "color2"),
    widget.Image(
        **base(bg="dark"),
        filename="~/.config/qtile/icons/skull-74-256.ico",
        mouse_callbacks={
            "Button1": lazy.spawn(
                "/home/arrase/.config/eww/scripts/openControlCenter.sh"
            )
        },
        fontsize=15,
    ),
    widget.Image(
        **base(bg="dark"),
        filename="~/.config/qtile/icons/message-icon-png-14918.png",
        mouse_callbacks={
            "Button1": lazy.spawn(
                "/home/arrase/.config/eww/scripts/openNotificationCenter.sh"
            )
        },
    ),
    powerline("active", "dark"),
    widget.TextBox(
        **base(bg="active"),
        font="Iosevka Nerd Font",
        fontsize=15,
        text=" ",
    ),
    widget.Clock(
        **base(bg="active"),
        font="Iosevka Nerd Font",
        format="%I:%M %p ",
        fontsize=15,
    ),
    powerline("dark", "active"),
    widget.QuickExit(
        **base(bg="dark", fg="color1"),
        font="Iosevka Nerd Font",
        default_text=" ⏻  ",
        fontsize=20,
    ),
]

widget_defaults = {
    "font": "Iosevka Nerd Font",
    "fontsize": 14,
    "padding": 1,
}
extension_defaults = widget_defaults.copy()
