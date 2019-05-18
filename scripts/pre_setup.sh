#!/bin/bash

pre_setup() {
	includes=(
		"kitty"
		"neofetch"
		"nvim"
		"nvim/colors"
		"nvim/plugin"
		"prompt"
	)

	echo -e "\nChecking if homebrew exists..."
	if [[ ! $(which brew) ]] && [[ ! $(brew --version &> /dev/null) ]]; then
		echo "Could not find existing homebrew installation."
		echo "Now installing..."
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "Found existing homebrew installation."
		echo "Proceeding..."
	fi

	for inc in ${includes[@]}
	do
		echo -e "\nChecking if '$HOME/.config/$inc' exists..."
		if [ ! -d  "$HOME/.config/$inc" ]; then
			echo "Couldn't find directory '$HOME/.config/$inc'."
			echo "Creating directory '$HOME/.config/$inc'"
			mkdir -p $HOME/.config/$inc
			echo "Proceeding..."
		else
			echo "Directory '$HOME/.config/$inc' already exists."
			echo "Proceeding..."
		fi
	done

	echo -e "Done.\n"
}

pre_setup
