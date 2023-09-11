from libqtile import widget
from .theme import colors
from libqtile.command import lazy

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="", # Icon: nf-oct-triangle_left
        fontsize=37,
        padding=-2
    )


def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='Iosevka Nerd Font',
            fontsize=17,
            margin_y=2,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),

    separator(),
    
    icon(bg="color3", text=' '),  # Icon: nf-fa-feed
    widget.Net(**base(bg='color3'), interface='wlp2s0'),

    widget.TextBox(
        font = "Iosevka Nerd Font",
        fontsize = 15,
        text = " 墳",
        background="#181825",
        foreground='#fff',
    ),

    widget.Volume(
        background="#181825",
        foreground="#fff",
    ),

    
# mose_callbacks={'Button1': ('def-nmdmenu')}
    widget.TextBox(
        font = "Iosevka Nerd Font",
        fontsize = 15,
        text="  ",
        # text="B ",
        background="#181825",
        foreground="#cdd6f4",
    ),
    widget.Battery(
        background="#181825",
        # foreground='#fff',
        format='{percent:2.0%}'
    ),

    powerline('dark', 'color1'),

    widget.TextBox(
        font = "Iosevka Nerd Font",
        fontsize = 15,
        text = " ",
        background="#181825",
        # foreground=colors_magenta,
    ),
    widget.Clock(
        format = '%I:%M %p ',
        background="#181825",
        # foreground=colors_white,
    ),
    widget.Image(
        filename = "~/.config/qtile/icons/skull-74-256.ico",
        mouse_callbacks={'Button1': lazy.spawn('/home/arrase/.config/eww/scripts/openControlCenter.sh')},
    ),

    widget.Image(
        filename = "~/.config/qtile/icons/message-icon-png-14918.png",
        mouse_callbacks={'Button1': lazy.spawn('/home/arrase/.config/eww/scripts/openNotificationCenter.sh')},
    ),

    widget.Systray(
        background= "#181825",
    ),
    widget.QuickExit(
        background="#181825",
        foreground="#e06c75",
        default_text = " ⏻  ",
        fontsize=20,
    ),


]

secondary_widgets = [
    *workspaces(),

    separator(),

    powerline('color1', 'dark'),

    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),

    widget.CurrentLayout(**base(bg='color1'), padding=5),

    powerline('color2', 'color1'),
   
    widget.Clock(**base(bg='color2'), format='%d/%m/%Y - %H:%M '),

    powerline('dark', 'color2'),


   ]

widget_defaults = {
    'font': 'Iosevka Nerd Font',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
