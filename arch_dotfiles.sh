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
	echo ""

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
			*) echo "Invalid option: $REPLY";;
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

	for FOLDER in "${folders[@]}"; do
		echo "Symlinking files in $FOLDER ..."

		if [[ "$FOLDER" == "tilde" ]]; then
			symlink_tilde_files
		else
			if [[ ! -d "${HOME}/$FOLDER" ]]; then
				mkdir -p "${HOME}/$FOLDER"
			fi

			symlink_files $FOLDER
		fi

	done

	echo ""

	confirm_hardware

	shopt -u dotglob

	echo ""

	set_shell

	echo "DONE."
}

setup_dotfiles
