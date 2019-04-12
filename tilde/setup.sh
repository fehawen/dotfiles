#!/bin/bash

# TODO:
# Check if chunkwm and skdh exists, else install them with brew.

symlink() {
	echo -e "\nSymlinking '$HOME/$1'"
	ln -sfv "$(PWD)/$1" "$HOME/$1" || error "Failed to symlink $1"
}

declare -a includes=(
	.chunkwmrc
	.ctags
	.bashrc
	.bash_profile
	.hushlogin
	.skhdrc
)

initialize() {
	read -r -p "Include tilde config files? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Installation declined..."
		echo -e "Now exiting.\n"
		exit
	else
		setup
	fi
}

setup() {
	echo -e "\nSetting up tilde files..."

	echo "Resetting PATH to avoid duplication."
	PATH=$(getconf PATH)

	echo "Checking which shell..."
	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		echo "Shell is already set to $SHELL"
	else
		echo "Shell is set to $SHELL"
		echo "Changing shell to /bin/bash"
	 	chsh -s /bin/bash
	 fi

	for inc in "${includes[@]}"
	do
		symlink "$inc"
	done

	echo -e "Done.\n"
}

initialize
