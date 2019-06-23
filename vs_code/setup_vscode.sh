#!/usr/bin/env sh

setup_vscode() {
	if [[ ! $(ls /Applications/ | grep -i visual\ studio\ code) ]]; then
		echo "Could not find existing VSCODE installation."
		echo "Please install it manually."
	else
		ln -sfv "$PWD/settings.json" $HOME/Library/Application\ Support/Code/User
	fi
}

setup_vscode
