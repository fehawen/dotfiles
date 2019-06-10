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

	echo "Done."
	printf "\n\n"
}

make_config_dir() {
	echo "Checking if directory '$HOME/.config' exists..."

	if [ ! -d  "$HOME/.config" ]; then
		echo "Couldn't find directory '$HOME/.config'"
		mkdir -v $HOME/.config
	else
		echo "Directory '$HOME/.config' already exists."
	fi

	echo "Done."
	printf "\n\n"
}

initialize() {
	set_shell
	make_config_dir

	if [[ "$OSTYPE" =~ "darwin" ]]; then
		echo "Setting up macOS config..."
		./setup_macos.sh
	elif [[ "$OSTYPE" =~ "linux" ]]; then
		echo "Setting up Arch Linux config..."
		./setup_arch.sh
	fi
}

initialize
