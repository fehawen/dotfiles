#!/bin/sh

darwin_pre_setup() {
	echo "Checking if HOMEBREW exists."
	if [[ ! $(which brew) ]] && [[ ! $(brew --version &> /dev/null) ]]; then
		echo "Could not find existing HOMEBREW installation."
		echo "Now installing."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "Found existing HOMEBREW installation."
		echo "Proceeding."
	fi
}

pre_setup() {
	includes=(
		"kitty"
		"neofetch"
		"nvim"
		"nvim/colors"
		"nvim/plugin"
		"prompt"
	)

	if [[ "$OSTYPE" =~ "darwin" ]]; then
		darwin_pre_setup
	fi

	echo "Checking if directory '$HOME/.config' exists..."
	if [ ! -d  "$HOME/.config" ]; then
		echo "Couldn't find directory '$HOME/.config'"
		mkdir -v $HOME/.config
	else
		echo "Directory '$HOME/.config' already exists."
	fi

	echo "Proceeding."

	for inc in ${includes[@]}
	do
		echo "Checking if directory '$HOME/.config/$inc' exists..."
		if [ ! -d  "$HOME/.config/$inc" ]; then
			echo "Couldn't find directory '$HOME/.config/$inc'"
			mkdir -v $HOME/.config/$inc
		else
			echo "Directory '$HOME/.config/$inc' already exists."
		fi

		echo "Proceeding."
	done

	echo "Done."
}

pre_setup
