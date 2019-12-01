#!/bin/bash

symlink_tilde_files() {
	declare -a tildes=(
		".bash_profile"
		".bashrc"
		".hushlogin"
		".inputrc"
		".profile"
		".xinitrc"
		".Xresources"
	)

	pushd "$PWD/tilde" > /dev/null

	for FILE in "${tildes[@]}"; do
		ln -sfv "$PWD/$FILE" "${HOME}/$FILE"
	done

	cd "$(dirs -l -0)" && dirs -c
}

symlink_hardware_specific_tilde_files() {
	pushd "$PWD/tilde/${1}"

	for FILE in *; do
		if [[ -f "$FILE" ]]; then
			ln -sfv "$PWD/$FILE" "${HOME}/$FILE"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

confirm_hardware() {
	echo -e "\nHardware specific configuration...\n"

	PS3="Please select your computer model: "

	declare -a options=(
		"Dell XPS 13 9343"
		"HP ProBook 650 G3"
		"Quit"
	)

	select OPT in "${options[@]}"
	do
		case $OPT in
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
			*) echo -e "\nInvalid option: $REPLY\n";;
		esac
	done
}

symlink_files() {
	pushd "$PWD/$1" > /dev/null

	for FILE in *; do
		if [ -f "$FILE" ]; then
			ln -sfv "$PWD/$FILE" "${HOME}/$1/$FILE"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

setup_dotfiles() {
	echo "Setting up Arch Linux config ..."

	declare -a folders=(
		".colors"
		".config/alacritty"
		".config/conky"
		".config/gtk-3.0"
		".config/i3"
		".config/kitty"
		".config/neofetch"
		".config/nvim"
		".config/nvim/colors"
		".config/nvim/plugin"
		".config/prompt"
		".config/ranger"
		".config/termite"
		".config/zathura"
		".newsboat"
		".surf/styles"
		"tilde"
		".wallpapers"
	)

	shopt -s dotglob

	for FOLDER in "${folders[@]}"; do
		echo -e "\nSymlinking files in $FOLDER ..."

		if [[ "$FOLDER" == "tilde" ]]; then
			symlink_tilde_files
		else
			if [[ ! -d "${HOME}/$FOLDER" ]]; then
				echo -e "\nDirectory $FOLDER does not exist."
				echo -e "\nCreating it..."
				mkdir -pv "${HOME}/$FOLDER"
			fi

			symlink_files $FOLDER
		fi
	done

	confirm_hardware
	shopt -u dotglob

	echo -e "DONE.\n"
}

setup_dotfiles
