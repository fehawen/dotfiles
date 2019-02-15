#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
bold=$(tput bold)
reset="$(tput sgr0)"

newline="\n"

includes=(
	"alacritty"
	"chunkwm"
	"nvim"
)

log() {
	printf "${newline}${green}INFO: $1${reset}"
}

msg() {
	printf "${newline}$1"
}

error() {
	printf "${newline}${red}ERROR: $1${reset}"
}

pre_setup() {
	for inc in ${includes[@]}
	do
		printf ${newline}
		read -r -p "${cyan}${bold}Include $inc? ${reset}[y/N] " answer
		if [ "$answer" != y ] && [ "$answer" != Y ]; then
			error "Excluding $inc..."
			msg "Proceeding..."
			printf "${newline}"
		else
			msg "Checking if '$HOME/.config/$inc' exists..."
			if [ ! -d  "$HOME/.config/$inc" ]; then
				msg "Couldn't find directory '$HOME/.config/$inc'."
				log "Creating directory '$HOME/.config/$inc'"
				mkdir -p $HOME/.config/$inc
				msg "Proceeding..."
				printf "${newline}"
			else
				log "Directory '$HOME/.config/$inc' already exists."
				msg "Proceeding..."
				printf "${newline}"
			fi
		fi
	done
	log "Done.${newline}"
}

pre_setup