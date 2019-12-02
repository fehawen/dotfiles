#!/bin/bash

install_packages() {
	echo -e "\nInstalling packages for Arch Linux...\n"

	# Include if needed
	# alacritty
	# kitty

	declare -a packages=(
		"xorg-server"
		"xorg-xinit"
		"xorg-xrandr"
		"xorg-xsetroot"
		"xorg-xbacklight"
		"xf86-video-intel"
		"xf86-input-libinput"
		"mesa"
		"python-pillow"
		"imagemagick"
		"alsa-utils"
		"alsa-lib"
		"pulseaudio"
		"pamixer"
		"dmenu"
		"i3-gaps"
		"i3lock"
		"conky"
		"termite"
		"chromium"
		"firefox"
		"surf"
		"gtop"
		"ranger"
		"neofetch"
		"scrot"
		"newsboat"
		"zip"
		"unzip"
		"p7zip"
		"npm"
		"docker"
		"docker-compose"
		"openssh"
		"zathura"
		"poppler"
		"zathura-pdf-poppler"
		"python-pip"
		"jshon"
		"noto-fonts-emoji"
	)

	sudo pacman -Syu ${packages[@]}

	echo -e "DONE.\n"
}

install_packages
