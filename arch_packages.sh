#!/bin/sh

install_packages() {
	echo "Installing packages for Arch Linux..."

	echo ""

	# For VirtualBox, if needed, add:
	# virtualbox
	# virtualbox-guest-utils
	# xf86-video-vmware (was required a while back, not sure if it still is, but works without for me)

	packages=(
		"mesa"
		"xf86-video-intel"
		"xf86-input-libinput"
		"pacman-contrib"
		"xorg-server"
		"xorg-xinit"
		"xorg-xrandr"
		"xorg-xsetroot"
		"xorg-xbacklight"
		"python-pillow"
		"imagemagick"
		"alsa-utils"
		"alsa-lib"
		"pulseaudio"
		"pamixer"
		"i3-gaps"
		"i3lock"
		"conky"
		"kitty"
		"dmenu"
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
		"npm"
		"docker"
		"docker-compose"
		"zathura"
		"poppler"
		"zathura-pdf-poppler"
		"python-pip"
		"jshon"
	)

	command sudo pacman -Syu ${packages[@]}

	echo "DONE."

	echo ""

}

install_packages
