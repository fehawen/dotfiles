#!/bin/sh

install_packages() {
	echo ""

	echo "Installing packages for Arch Linux..."

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
	)

	command sudo pacman -Syu ${packages[@]}

	echo "DONE."

	echo ""
}

configure_touchpad() {
	read -r -p "Configure touchpad? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Skipping touchpad configuration..."
		echo ""
	else

		echo ""

		echo "Configuring touchpad..."

		echo ""

		echo "Writing content to '/usr/share/X11/xorg.conf.d/40-libinput.conf'..."

sudo tee -a /usr/share/X11/xorg.conf.d/40-libinput.conf >> /dev/null << EOT

Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Option "Tapping" "true"
        Option "TappingDrag" "false"
        Option "NaturalScrolling" "true"
        Option "AccelProfile" "linear"
        Option "AccelSpeed" "0.25"
        Option "DisableWhileTyping" "false"
        Driver "libinput"
EndSection

EOT

		echo "DONE."

		echo ""

	fi
}

enable_docker() {
	read -r -p "Start and enable Docker? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Skipping Docker..."
		echo ""
	else

		echo "Starting Docker through systemctl..."

		command systemctl start docker

		echo ""

		echo "Starting Docker through systemctl..."

		command systemctl enable docker

		echo "DONE."

		echo ""

	fi
}

install_packages
configure_touchpad
enable_docker
