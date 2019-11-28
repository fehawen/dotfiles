#!/bin/bash

setup_homebrew() {
	if [[ ! $(which brew) ]] && [[ ! $(brew --version &> /dev/null) ]]; then
		echo -e "\nCould not find existing HOMEBREW installation."
		echo -e "\nNow installing..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

setup_vscode() {
	pushd "$PWD/vs_code" > /dev/null

	./setup_vscode.sh

	cd "$(dirs -l -0)" && dirs -c
}

symlink_tilde_files() {
	declare -a tildes=(
		".bash_profile"
		".bashrc"
		".chunkwmrc"
		".hushlogin"
		".inputrc"
		".profile"
		".skhdrc"
	)

	pushd "$PWD/tilde" > /dev/null

	for FILE in "${tildes[@]}"; do
		ln -sfv "$PWD/$FILE" "${HOME}/$FILE"
	done

	cd "$(dirs -l -0)" && dirs -c
}

symlink_files() {
	pushd "$PWD/$1" > /dev/null

	for FILE in *; do
		if [[ -f "$FILE" ]]; then
			ln -sfv "$PWD/$FILE" "${HOME}/$1/$FILE"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

setup_dotfiles() {
	echo -e "\nSetting up macOS config...\n"

	declare -a folders=(
		".config/kitty"
		".config/neofetch"
		".config/nvim"
		".config/nvim/colors"
		".config/nvim/plugin"
		".config/prompt"
		".config/ranger"
		".newsboat"
		"tilde"
	)

	shopt -s dotglob

	for FOLDER in "${folders[@]}"; do
		if [[ ! -d "${HOME}/$FOLDER" ]]; then
			mkdir -p "${HOME}/$FOLDER"
		fi

		echo -e "\nSymlinking files in $FOLDER ..."

		if [[ "$FOLDER" == "tilde" ]]; then
			symlink_tilde_files
		else
			symlink_files $FOLDER
		fi
	done

	shopt -u dotglob

	setup_homebrew
	setup_vscode

	echo -e "DONE.\n"
}

setup_dotfiles
