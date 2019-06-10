#!/usr/bin/env bash

setup_homebrew() {
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

setup_kitty() {
	kitty=(
		"industrial.conf"
		"industrial_transparent.conf"
		"recursive.conf"
		"kitty.conf"
	)

	if [[ ! "$(which kitty 2> /dev/null)" ]] && [[ ! $(ls /Applications/ | grep -i kitty 2> /dev/null) ]]; then
		echo "Couldn't find existing KITTY installation."
		echo "Now installing KITTY for macOS."
		curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	else
		echo "Existing KITTY installation found."
		echo "Proceeding."
	fi

	echo "Checking if directory '$HOME/.config/kitty' exists..."
	if [ ! -d  "$HOME/.config/kitty" ]; then
		echo "Couldn't find directory '$HOME/.config/kitty'"
		mkdir -v $HOME/.config/kitty
	else
		echo "Directory '$HOME/.config/kitty' already exists."
	fi

	for kit in ${kitty[@]}
	do
		cd ../.config/kitty/ && ln -sfv "$PWD/kitty/$kit" "$HOME/.config/kitty" || error "Failed to symlink $kit"
	done

	echo "Done."
}

setup_vscode() {
	echo "Setting up VSCODE config..."

	echo "Checking if VSCODE exists."
	if [[ ! $(ls /Applications/ | grep -i visual\ studio\ code) ]]; then
		echo "Could not find existing VSCODE installation."
		echo "Please install it manually."
	else
		echo "Existing VSCODE installation found."
		if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
			rm $HOME/Library/Application\ Support/Code/User/settings.json
		fi

		cd ../vs_code/ && ln -sfv "$PWD/settings.json" "$HOME/Library/Application\ Support/Code/User"
	fi

	echo "Done."
}


initialize() {
	includes=(
		"homebrew"
		"kitty"
		"vscode"
	)

	for inc in ${includes[@]}
	do
		local cased=$(echo "$inc" | tr "[:lower:]" "[:upper:]")

		read -r -p "Include $cased? [y/N] " answer

		if [ "$answer" != y ] && [ "$answer" != Y ]; then
			echo "Excluding $cased."
			echo "Proceeding..."
			exit
		else
			setup_$inc
			printf "\n\n"
		fi
	done
}

initialize
