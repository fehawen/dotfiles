#!/bin/bash

configure_touchpad() {
	read -r -p "Configure touchpad? [y/N] " answer
	if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
		echo -e "\nSkipping touchpad configuration...\n"
	else
		echo -e "\nConfiguring touchpad..."
		echo -e "\nWriting content to '/usr/share/X11/xorg.conf.d/40-libinput.conf'..."

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

		echo -e "DONE.\n"
	fi
}

enable_docker() {
	read -r -p "Start and enable Docker? [y/N] " answer
	if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
		echo -e "\nSkipping Docker systemctl setup...\n"
	else
		echo -e "\nStarting Docker through systemctl..."
		systemctl start docker

		echo -e "\nStarting Docker through systemctl..."
		systemctl enable docker

		echo -e "DONE.\n"
	fi
}

configure_docker() {
	read -r -p "Manage Docker as a non-root user? [y/N] " answer
	if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
		echo -e "\nSkipping Docker non-root configuration...\n"
	else
		echo -e "\nAdding 'docker' group..."
		sudo groupadd docker

		echo -e "\nAdding user $USER to 'docker' group..."
		sudo usermod -aG docker "$USER"

		echo -e "DONE.\n"
	fi
}

configure_npm() {
	read -r -p "Manage NPM as a non-root user? [y/N] " answer
	if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
		echo -e "\nSkipping NPM non-root configuration...\n"
	else
		local npm_dir="${HOME}/.npm-global"

		if [[ ! -d "$npm_dir" ]]; then
			echo -e "\nCreating dir ${npm_dir}..."
			mkdir -p "$npm_dir"
		else
			echo -e "\nDirectory ${npm_dir} already exists..."
		fi

		echo -e "\nAdding ${npm_dir} to npm config..."
		npm config set prefix "${HOME}/.npm-global"
		echo -e "DONE.\n"
	fi
}

configure_neovim() {
	read -r -p "Install dependencies for NeoVim and plugins? [y/N] " answer
	if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
		echo -e "\nSkipping NeoVim configuration...\n"
	else
		echo -e "\nEnabling Python3 with 'pip3 install --user pynvim' command..."
		pip3 install --user pynvim

		echo -e "\nInstalling neovim NPM package..."
		npm install -g neovim

		echo -e "DONE.\n"
	fi
}

configure_touchpad
enable_docker
configure_docker
configure_npm
configure_neovim

echo -e "Configuration completed.\n"
