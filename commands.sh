#!/usr/bin/env bash

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)
OK='\n\033[0;32m OK...\033[0m'

logo () {
	local text="${1:?}"
	echo -en "
	               %%%
	        %%%%%//%%%%%
	      %%************%%%
	  (%%//############*****%%
	%%%%%**###&&&&&&&&&###**//
	%%(**##&&&#########&&&##**
	%%(**##*****#####*****##**%%%
	%%(**##     *****     ##**
	   //##   @@**   @@   ##//
	     ##     **###     ##
	     #######     #####//
	       ###**&&&&&**###
	       &&&         &&&
	       &&&////   &&
	          &&//@@@**
	            ..***
			  arrase Script\n\n"
    printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
    sleep 5
}

logo "Welcome!"
printf '%sThis script will install needed dependencies and copy my dotfiles to your bspwm setup.%s\n\nThis installer script does NOT change any configuration of your system.\nIts just a script that copies and moves my dotfiles to your ~/.config directory\n\n' "${CRE}" "${CNC}"
sleep 3

while true; do
	read -rp " Do you wish to continue? [y/N]: " yn
		case $yn in
			[Yy]* ) break;;
			[Nn]* ) exit;;
			* ) printf " Error: just write 'y' or 'n'\n\n";;
		esac
    done
			clear

logo "Checking if yay is installed"

	if pacman -Qi yay >/dev/null 2>&1; then
		printf "Yay is installed\n\n"
	else
		printf "installing yay..\n\n"
		sudo pacman -Syu git && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd
	fi
sleep 2
echo "Create gnup"
sleep 2
mkdir -p ~/.local/share/gnupg
sleep 2
clear
logo "Installing needed packages.."

      sudo pacman -S ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels\
        ttf-font-awesome telegram-desktop nodejs npm xdotool lazygit wine --needed

	  yay -S --needed \
        sxhkd bspwm alacritty polybar fish neovim stalonetray \
        plank dunst rofi jgmenu xprintidle i3lock-color zathura \
        broot fzf mpv neofetch ranger ueberzug xdo perl cava \
        xbanish xss-lock pavucontrol nitrogen flameshot exa bat copyq \
        maim ant-dracula-kvantum-theme-git ant-dracula-theme-git \
        papirus-icon-theme kvantum pacman-contrib xorg-xbacklight \
        imagemagick nerd-fonts-cozette-ttf scientifica-font font-awesome-5\
        blueman colorpicker imagemagick jq kitty light lxappearance mantablockscreen\
        playerctl polkit-gnome scrot sox spicetify-cli spotify sysstat tumbler wmctrl\
        wpgtk-git acpi alsa-utils-git xorg-xwininfo picom-animations-git


clear

logo "Cloning REPO!"
printf "Cloning rice from https://github.com/arrase21/dot-files\n\n"
git clone --depth=1 https://github.com/arrase21/dot-files.git
sleep 2
clear

logo "Backup your files"
printf "Backup files will be stored in %s%s/YourBackups%s \n\n" "${CRE}" "$HOME" "${CNC}"
sleep 5

if [ ! -d "$HOME/YourBackups" ]; then
	mkdir "${HOME}"/YourBackups
fi

[ -e ~/.config/bspwm ] && mv ~/.config/bspwm ~/YourBackups/bspwm-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/bspwm ] && mv ~/.config/btop ~/YourBackups/btop-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/copyq ] && mv ~/.config/copyq ~/YourBackups/copyq-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/dunst ] && mv ~/.config/dunst ~/YourBackups/dunst-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/fish ] && mv ~/.config/fish ~/YourBackups/fish"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/gtk-2.0 ] && mv ~/.config/gtk-3.0 ~/YourBackups/gtk-3.0-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/gtk-3.0 ] && mv ~/.config/gtk-3.0 ~/YourBackups/gtk-3.0-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/hypr ] && mv ~/.config/hypr ~/YourBackups/hypr-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/hypr2 ] && mv ~/.config/hypr2 ~/YourBackups/hypr2-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/jgmenu ] && mv ~/.config/jgmenu ~/YourBackups/jgmenu-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/kitty ] && mv ~/.config/kitty ~/YourBackups/alacritty-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/networkmanager-dmenu ] && mv ~/.config/networkmanager-dmenu  ~/YourBackups/networkmanager-dmenu -backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/nitrogen ] && mv ~/.config/nitrogen ~/YourBackups/nitrogen-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/YourBackups/nvim-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/picom ] && mv ~/.config/picom ~/YourBackups/picom-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/polybar ] && mv ~/.config/polybar ~/YourBackups/polybar-backup"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/ranger ] && mv ~/.config/ranger ~/YourBackups/ranger-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/rofi ] && mv ~/.config/rofi ~/YourBackups/rofi-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/sxhkd ] && mv ~/.config/sxhkd ~/YourBackups/sxhkd-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/stalonetrayrc ] && mv ~/.config/stalonetrayrc ~/YourBackups/stalonetrayrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/waybar ] && mv ~/.config/waybar ~/YourBackups/waybar-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/termite ] && mv ~/.config/termite ~/YourBackups/termite-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/eww ] && mv ~/.config/eww ~/YourBackups/eww-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/mpd ] && mv ~/.config/mpd ~/YourBackups/mpd-backup-"$(date +%Y.%m.%d-%H.%M.%S)"
[ -e ~/.config/ncmpcpp ] && mv ~/.config/ncmpcpp ~/.RiceBackup/ncmpcpp-backup-"$(date +%Y.%m.%d-%H.%M.%S)"

printf "\n\nDone\n\n"
sleep 2
clear

logo "Copying Rice.."
printf "Copying files to respective directories..\n\n"

if [ -d "$HOME/.config" ]; then
	cp -r ~/repos/dot-files/.config/* ~/.config
else
	mkdir -p ~/.config && cp -r ~/repos/dot-files/config/* ~/.config
fi

cp -r ~/repos/dot-files/.bin/ ~/
cp -r ~/repos/dot-files/.profile ~/
cp -r ~/repos/dot-files/.Xresources ~/
cp -r ~/repos/dot-files/Scripts/* ~/
cp -r ~/repos/dot-files/.bscripts/ ~/
cp -r -f -T ~/repos/dot-files/Walcache ~/.cache/wal
cp -r ~/repos/dot-files/rice_assets/ ~/.config



echo -n "Changing script permissions... "
chmod +x ~/.bscripts/*
chmod +x ~/.config/bspwm/quit.sh
chmod +x ~/.config/wpg/wp_init.sh
chmod +x ~/.cache/wal/colors-tty.sh
echo "done"

if [ -d "$HOME/.local/bin" ]; then
	cp -r ~/repos/dot-files/.local/bin/* ~/.local/bin
else
	mkdir -p ~/.local/bin && cp -r ~/repos/dot-files/.local/bin/* ~/.local/bin
fi

if [ -d "$HOME/.local/share/fonts" ]; then
	cp -r ~/repos/dot-files/fonts/* ~/.local/share/fonts
else
	mkdir -p ~/.local/share/fonts && cp -r ~/repos/dot-files/fonts/* ~/.local/share/fonts
fi


printf "\n\nFiles copied succesfully\n\n"
sleep 2
clear

logo "Reloading fonts.."
printf "Reloading fonts to make it usable \n\n"

## Reloading fonts
fc-cache -rv >/dev/null 2>&1

printf "\n\nFonts reloaded succesfully!\n\n"
sleep 2
clear

logo "Enabling MPD service"
# For automatically launching mpd on login
systemctl --user enable mpd.service
systemctl --user start mpd.service

printf "\n\nDone\n\n"
sleep 2
clear

echo "Running wpg-install.sh -g for the gtk colorscheme"
chmod +x "$script_dir"/wpg-install.sh 
"$script_dir"/wpg-install.sh -g 

logo "Installation finished"
printf "%sNow logout your session, select bspwm and log in.%s \n\n" "${CRE}" "${CNC}"
zsh
