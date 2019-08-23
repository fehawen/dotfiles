#!/bin/sh

set_shell() {
	echo "Checking which SHELL..."

	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		echo "SHELL is already set to $SHELL"
	else
		echo "SHELL is set to $SHELL"
		echo "Changing SHELL to /bin/bash."
		chsh -s /bin/bash
	fi
}

symlink_tilde_files() {
	tildes=(
		".bash_profile"
		".bashrc"
		".hushlogin"
		".inputrc"
		".profile"
		".xinitrc"
		".Xresources"
	)

	pushd "$PWD/tilde" > /dev/null

	for file in "${tildes[@]}"; do
		ln -sfv "$PWD/$file" "$HOME/$file"
	done

	cd "$(dirs -l -0)" && dirs -c
}

symlink_hardware_specific_tilde_files() {
	pushd "$PWD/tilde/${1}"

	for file in *; do
		if [ -f "$file" ]; then
			ln -sfv "$PWD/$file" "$HOME/$file"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

confirm_hardware() {
	echo ""

	PS3="Please select your computer model: "

	options=(
		"Dell XPS 13 9343"
		"HP ProBook 650 G3"
		"Quit"
	)

	select opt in "${options[@]}"
	do
		case $opt in
			"Dell XPS 13 9343")
				symlink_hardware_specific_tilde_files "xps"
				break
				;;
			"HP ProBook 650 G3")
				symlink_hardware_specific_tilde_files "probook"
				break
				;;
			"Quit")
				break
				;;
			*) echo "Invalid option: $REPLY";;
		esac
	done
}

symlink_files() {
	pushd "$PWD/$1" > /dev/null

	for file in *; do
		if [ -f "$file" ]; then
			ln -sfv "$PWD/$file" "$HOME/$1/$file"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

setup_arch() {
	echo "Setting up Arch Linux config ..."

	folders=(
		".config/conky"
		".config/i3"
		".config/kitty"
		".config/neofetch"
		".config/nvim"
		".config/nvim/colors"
		".config/nvim/plugin"
		".config/prompt"
		".config/ranger"
		".config/zathura"
		".newsboat"
		".surf/styles"
		"tilde"
		".wallpapers"
	)

	shopt -s dotglob

	for folder in "${folders[@]}"; do
		echo "Symlinking files in $folder ..."

		if [[ "$folder" == "tilde" ]]; then
			symlink_tilde_files
		else
			if [[ ! -d "$HOME/$folder" ]]; then
				mkdir -p "$HOME/$folder"
			fi

			symlink_files $folder
		fi

	done

	echo ""

	confirm_hardware

	shopt -u dotglob

	echo ""

	set_shell

	echo "DONE."
}

setup_arch
