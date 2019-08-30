#!/bin/sh

confirm() {
	read -r -p "Proceed with dotfiles setup for $1? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Setup declined..."
		echo "Now exiting."
		exit
	else
		./setup_$1.sh
	fi
}

PS3="Please select your OS: "

options=(
	"Dotfiles for Arch Linux"
	"Dotfiles for macOS"
	"Quit"
)

select opt in "${options[@]}"
do
	case $opt in
		"Dotfiles for Arch Linux")
			confirm "arch"
			break
			;;
		"Dotfiles for macOS")
			confirm "macos"
			break
			;;
		"Quit")
			break
			;;
		*) echo "Invalid option: $REPLY";;
	esac
done
