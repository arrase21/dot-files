#!/usr/bin/env bash
#  ╦═╗╦╔═╗╔═╗  ╦╔╗╔╔═╗╔╦╗╔═╗╦  ╦  ╔═╗╦═╗
#  ╠╦╝║║  ║╣   ║║║║╚═╗ ║ ╠═╣║  ║  ║╣ ╠╦╝
#  ╩╚═╩╚═╝╚═╝  ╩╝╚╝╚═╝ ╩ ╩ ╩╩═╝╩═╝╚═╝╩╚═
#	Script to install my dotfiles
#   Author: z0mbi3
#	url: https://github.com/gh0stzk

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

backup_folder=~/.RiceBackup
date=$(date +%Y%m%d-%H%M%S)

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
			  z0mbi3 Dotfiles\n\n"
    printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
}

########## ---------- You must not run this as root ---------- ##########

if [ "$(id -u)" = 0 ]; then
    echo "This script MUST NOT be run as root user."
    exit 1
fi

########## ---------- Welcome ---------- ##########

logo "Welcome!"
printf '%s%sThis script will check if you have the necessary dependencies, and if not, it will install them. Then, it will clone the RICE in your HOME directory.\nAfter that, it will create a secure backup of your files, and then copy the new files to your computer.\n\nMy dotfiles DO NOT modify any of your system configurations.\nYou will be prompted for your root password to install missing dependencies and/or to switch to zsh shell if its not your default.\n\nThis script doesnt have the potential power to break your system, it only copies files from my repository to your HOME directory.%s\n\n' "${BLD}" "${CRE}" "${CNC}"

while true; do
	read -rp " Do you wish to continue? [y/N]: " yn
		case $yn in
			[Yy]* ) break;;
			[Nn]* ) exit;;
			* ) printf " Error: just write 'y' or 'n'\n\n";;
		esac
    done
clear

########## ---------- Install packages ---------- ##########

logo "Installing needed packages.."


dependencias=(sxhkd bspwm alacritty fish neovim stalonetray telegram-desktop rustup polybar opera\
        ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-inconsolata ttf-joypixels \
	webp-pixbuf-loader pamixer libwebp ncmpcpp mpc feh wezterm tmux\
	jq polkit-gnome playerctl mpd xclip lsd qtile\
        dunst rofi jgmenu xprintidle i3lock-color zathura xdotool nodejs \
        broot fzf mpv neofetch ranger ueberzug xdo perl cava npm\
        xbanish xss-lock pavucontrol nitrogen flameshot exa bat copyq \
        maim ant-dracula-kvantum-theme-git ant-dracula-theme-git \
        papirus-icon-theme kvantum pacman-contrib xorg-xbacklight brightnessctl\
        imagemagick nerd-fonts-cozette-ttf scientifica-font font-awesome-5)


is_installed() {
  yay -Qi "$1" &> /dev/null
  return $?
}

printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for paquete in "${dependencias[@]}"
do
  if ! is_installed "$paquete"; then
    sudo yay -S "$paquete" --noconfirm
    printf "\n"
  else
    printf '%s%s is already installed on your system!%s\n' "${CGR}" "$paquete" "${CNC}"
    sleep 1
  fi
done
sleep 3
clear

########## ---------- Preparing Folders ---------- ##########

logo "Preparing Folders"
if [ ! -e $HOME/.config/user-dirs.dirs ]; then
	xdg-user-dirs-update
	echo "Creating xdg-user-dirs"
else
	echo "user-dirs.dirs already exists"
fi
sleep 2 
clear

########## ---------- Cloning the Rice! ---------- ##########

logo "Downloading dotfiles"
printf "Cloning rice from https://github.com/arrase/dot-files\n"
cd
cd repos
git clone --depth=1 https://github.com/arrase21/dot-files
sleep 2
clear

########## ---------- Backup files ---------- ##########

logo "Backup files"
printf "Backup files will be stored in %s%s%s/.RiceBackup%s \n\n" "${BLD}" "${CRE}" "$HOME" "${CNC}"
sleep 10

if [ ! -d "$backup_folder" ]; then
  mkdir -p "$backup_folder"
fi

for folder in bspwm alacritty picom rofi eww sxhkd dunst polybar ncmpcpp nvim ranger zsh mpd paru; do
  if [ -d "$HOME/.config/$folder" ]; then
    mv "$HOME/.config/$folder" "$backup_folder/${folder}_$date"
    echo "$folder folder backed up successfully at $backup_folder/${folder}_$date"
  else
    echo "The folder $folder does not exist in $HOME/.config/"
  fi
done


printf "%s%sDone!!%s\n\n" "${BLD}" "${CGR}" "${CNC}"
sleep 5

########## ---------- Copy the Rice! ---------- ##########

logo "Installing dotfiles.."
printf "Copying files to respective directories..\n"


for archivos in ~/repos/dot-files/.config/*; do
  cp -R "${archivos}" ~/.config/
  if [ $? -eq 0 ]; then
	printf "%s%s%s folder copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/repos/dot-files/.bin; do
  cp -R "${archivos}" ~/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/repos/dot-files/.local/bin/; do
  cp -R "${archivos}" ~/.local/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done


for archivos in ~/repos/dot-files/.bscripts; do
  cp -R "${archivos}" ~/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/repos/dot-files/rice_assets; do
  cp -R "${archivos}" ~/.config/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/repos/dot-files/.profile; do
  cp -R "${archivos}" ~/
  if [ $? -eq 0 ]; then
	printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done

for archivos in ~/repos/dot-files/.Xresources; do
cp -R "${archivos}" ~/
if [ $? -eq 0 ]; then
printf "%s%s%s file copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
sleep 1
else
printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
sleep 1
fi
done



for archivos in ~/repos/dot-files/fonts/*; do
  cp -R "${archivos}" ~/.local/share/fonts/
  if [ $? -eq 0 ]; then
	printf "%s%s%s copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	sleep 1
  else
	printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
	sleep 1
  fi
done



sleep 3

########## ---------- Installing Paru & Eww from source ---------- ##########

logo "installing Paru & Eww"

if ! command -v paru >/dev/null 2>&1; then
	printf "%s%sInstalling paru%s\n" "${BLD}" "${CBL}" "${CNC}"
	cd
	git clone https://aur.archlinux.org/paru-bin.git
	cd paru-bin
	makepkg -si --noconfirm
	cd
else
	printf "%s%sParu is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
fi

if ! command -v eww >/dev/null 2>&1; then 
	printf "\n%s%sInstalling Eww, this could take 10 mins or more.%s\n" "${BLD}" "${CBL}" "${CNC}"
	curl -sS https://github.com/elkowar.gpg | gpg --import -i -
	curl -sS https://github.com/web-flow.gpg | gpg --import -i -
	paru -S eww-x11 --skipreview --noconfirm
	rm -rf {paru-bin,.cargo,.rustup}
	rm -rf $HOME/.cache/paru/clone/eww
else
	printf "\n%s%sEww is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
fi

## Intalling tdrop for scratchpads
if ! command -v tdrop >/dev/null 2>&1; then
	printf "\n%s%sInstalling tdrop, this must be fast!.%s\n" "${BLD}" "${CBL}" "${CNC}"
	paru -S tdrop-git --skipreview --noconfirm
else
	printf "\n%s%sTdrop is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
fi

########## ---------- Enabling MPD service ---------- ##########

logo "Enabling mpd service"

systemctl --user enable mpd.service
systemctl --user start mpd.service
printf "%s%sDone!!%s\n\n" "${BLD}" "${CGR}" "${CNC}"
sleep 2

########## --------- Changing shell to zsh ---------- ##########

logo "Changing default shell to fish"
printf "%s%sIf your shell is not zsh will be changed now.\nYour root password is needed to make the change.\n\nAfter that is important for you to reboot.\n %s\n" "${BLD}" "${CYE}" "${CNC}"
if [[ $SHELL != "/usr/bin/fish" ]]; then
  echo "Changing shell to zsh, your root pass is needed."
  chsh -s /usr/bin/fish
else
  printf "%s%sYour shell is already fish\nGood bye! installation finished, now reboot%s\n" "${BLD}" "${CGR}" "${CNC}"
  zsh
fi
