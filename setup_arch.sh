#!/bin/sh

set_shell() {
	echo "\n"
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
		".config/kitty"
		".config/neofetch"
		".config/nvim"
		".config/nvim/colors"
		".config/nvim/plugin"
		".config/prompt"
		".config/zathura"
		".newsboat"
		"tilde"
	)

	shopt -s dotglob

	for folder in "${folders[@]}"; do
		echo "\n"
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

	shopt -u dotglob

	set_shell

	echo "\n"
	echo "DONE."
}

setup_arch
