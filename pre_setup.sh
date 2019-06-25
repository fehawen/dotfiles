#!/bin/sh

confirm() {
	read -r -p "Proceed with setup for $1? [y/N] " answer
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
	"Arch Linux"
	"macOS"
	"Quit"
)

select opt in "${options[@]}"
do
	case $opt in
		"Arch Linux")
			confirm "arch"
			break
			;;
		"macOS")
			confirm "macos"
			break
			;;
		"Quit")
			break
			;;
		*) echo "Invalid option: $REPLY";;
	esac
done
