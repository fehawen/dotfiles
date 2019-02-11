#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"

newline='
'

log() {
	printf "${newline}${green}INFO: $1${reset}"
}

error() {
	printf "${newline}${red}ERROR: $1${reset}"
}

initialize() {
	printf "${newline}"
	read -r -p "${cyan}Setup NeoVim config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "NeoVim setup declined..."
		error "Now exiting."
		printf "${newline}${newline}"
		exit
	else
		setup
	fi
}

setup() {
	log "Setting up NeoVim config..."

	timestamp=$(date +"%Y%m%d-%H:%M:%S")

	if [ -f "$HOME/.config/nvim/init.vim" ]; then
		log "Making backup of '$HOME/.config/nvim/init.vim' to '$HOME/.config/nvim/init.vim.backup.$timestamp'"
		mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.backup.$timestamp
	fi

	log "Symlinking init.vim..."
	ln -sf "$(PWD)/init.vim" $HOME/.config/nvim/

	log "NeoVim setup complete."
	printf "${newline}${newline}"
}

initialize