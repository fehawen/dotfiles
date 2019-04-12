#!/bin/bash

initialize() {
	read -r -p "Include vs code? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo -e "\nExcluding vs code..."
		echo -e "Done.\n"
		exit
	else
		setup
	fi
}

setup() {
	echo -e "\nSetting up vs code config..."

	if [[ ! $(ls /Applications/ | grep -i visual\ studio\ code) ]]; then
		echo -e "\nCould not find existing vs code installation."
		echo "Please install it manually."
	else
		if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
			rm $HOME/Library/Application\ Support/Code/User/settings.json
		fi

		echo -e "\nSymlinking settings.json..."
		ln -sf "$(pwd)/settings.json" $HOME/Library/Application\ Support/Code/User/settings.json
	fi

	echo -e "Done.\n"
}

initialize
