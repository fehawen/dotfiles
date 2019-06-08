#!/usr/bin/env sh

# Universal dotfiles, i.e. macOS and Linux
declare -a includes=(
	.bashrc
	.bash_profile
	.hushlogin
	.inputrc
	.profile
)

# macOS only dotfiles
declare -a darwin_includes=(
	.chunkwmrc
	.skhdrc
)

# macOS only setup
setup_darwin_configs() {
	echo "Checking if CHUNK WM exists."

	if [[ ! $(which chunkwm) ]] && [[ ! $(brew ls --versions chunkwm) ]]; then
		echo "Couldn't find existing CHUNK WM installation."
		echo "Now installing."
		brew install chunkwm
	else
		echo "Existing CHUNK WM installation found."
		echo "Proceeding."
	fi

	echo "Checking if SKHD exists."

	if [[ ! $(which skhd) ]] && [[ ! $(brew ls --versions skhd) ]]; then
		echo "Couldn't find existing SKHD installation."
		echo "Now installing."
		brew install skhd
	else
		echo "Existing SKHD installation found."
		echo "Proceeding."
	fi
}

# Universal setup, i.e. macOS and Linux
setup() {
	echo "Setting up TILDE files."

	for inc in "${includes[@]}"
	do
		ln -sfv "$PWD/$inc" "$HOME/$inc" || error "Failed to symlink $inc"
	done

	# macOS only configs
	if [[ "$OSTYPE" =~ "darwin" ]]; then
		echo "Setting up additional TILDE files for MAC OS."

		setup_darwin_configs

		for dinc in "${darwin_includes[@]}"
		do
			ln -sfv "$PWD/$dinc" "$HOME/$dinc" || error "Failed to symlink $dinc"
		done
	fi

	echo "Prompt themes will be setup in the next step."
	echo "Done."
}

# Entry point
initialize() {
	read -r -p "Include TILDE config files? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding TILDE files."
		echo "Proceeding."
		exit
	else
		setup
	fi
}

initialize
