#!/usr/bin/env sh

initialize() {
	read -r -p "Include VS CODE? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding VS CODE."
		echo "Proceeding."
		echo "Done."
		exit
	else
		setup
	fi
}

setup() {
	echo "Setting up VS CODE config."
	echo "Checking if VS CODE exists."

	if [[ ! $(ls /Applications/ | grep -i visual\ studio\ code) ]]; then
		echo "Could not find existing VS CODE installation."
		echo "Please install it manually."
	else
		echo "Existing VS CODE installation found."
		if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
			rm $HOME/Library/Application\ Support/Code/User/settings.json
		fi

		ln -sfv "$PWD/settings.json" $HOME/Library/Application\ Support/Code/User/settings.json
	fi

	echo "Done."
}

if [[ "$OSTYPE" =~ "darwin" ]]; then
	initialize
fi
