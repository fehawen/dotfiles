#!/bin/sh

setup_homebrew() {
	if [[ ! $(which brew) ]] && [[ ! $(brew --version &> /dev/null) ]]; then
		echo "Could not find existing HOMEBREW installation."
		echo "Now installing..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

setup_vscode() {
	pushd "$PWD/vs_code" > /dev/null

	./setup_vscode.sh

	cd "$(dirs -l -0)" && dirs -c
}

symlink_tilde_files() {
	tildes=(
		".bash_profile"
		".bashrc"
		".chunkwmrc"
		".hushlogin"
		".inputrc"
		".profile"
		".skhdrc"
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

setup_dotfiles() {
	echo "Setting up macOS config ..."

	folders=(
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

	for folder in "${folders[@]}"; do
		if [[ ! -d "$HOME/$folder" ]]; then
			mkdir -p "$HOME/$folder"
		fi

		echo "Symlinking files in $folder ..."

		if [[ "$folder" == "tilde" ]]; then
			symlink_tilde_files
		else
			symlink_files $folder
		fi

	done

	shopt -u dotglob

	setup_homebrew
	setup_vscode

	echo "DONE."
}

setup_dotfiles
