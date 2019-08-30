#!/bin/sh

confirm() {
	read -r -p "Proceed with dotfiles setup for $1? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Setup declined..."
		echo "Now exiting."
		exit
	else
		./$1_$2.sh
	fi
}

PS3="Please select your OS: "

options=(
	"Dotfiles for Arch Linux"
	"Packages for Arch Linux"
	"Dotfiles for macOS"
	"Quit"
)

select opt in "${options[@]}"
do
	case $opt in
		"Dotfiles for Arch Linux")
			confirm "arch" "dotfiles"
			break
			;;
		"Packages for Arch Linux")
			confirm "arch" "packages"
			break
			;;
		"Dotfiles for macOS")
			confirm "macos" "dotfiles"
			break
			;;
		"Quit")
			break
			;;
		*) echo "Invalid option: $REPLY";;
	esac
done
