#!/bin/sh

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
		echo "Skipping Docker systemctl setup..."
		echo ""
	else

		echo ""

		echo "Starting Docker through systemctl..."

		command systemctl start docker

		echo ""

		echo "Starting Docker through systemctl..."

		command systemctl enable docker

		echo "DONE."

		echo ""

	fi
}

configure_docker() {
	read -r -p "Manage Docker as a non-root user? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Skipping Docker non-root configuration..."
		echo ""
	else

		echo ""

		echo "Adding 'docker' group..."

		command sudo groupadd docker

		echo ""

		echo "Adding user $USER to 'docker' group..."

		command sudo usermod -aG docker $USER

		echo "DONE."

		echo ""

	fi
}

configure_npm() {
	read -r -p "Manage NPM as a non-root user? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Skipping NPM non-root configuration..."
		echo ""
	else

		local npm_dir="${HOME}/.npm-global"

		echo ""

		if [[ ! -d "$npm_dir" ]]; then
			echo "Creating dir $npm_dir..."
			mkdir -p "$npm_dir"
		else
			echo "Directory $npm_dir already exists..."
		fi

		echo ""

		echo "Adding $npm_dir to npm config..."

		command npm config set prefix '~/.npm-global'

		echo "DONE."

		echo ""

	fi
}

configure_touchpad
enable_docker
configure_docker
configure_npm
