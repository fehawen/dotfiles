#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"

log() {
	echo -e "${green}INFO: $1${reset}"
}

error() {
	echo -e "${red}ERROR: $1${reset}"
}

initialize() {
	read -r -p "${cyan}Setup neovim config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Setup declined..."
		error "Now exiting."
		exit
	else
		setup
	fi
}

setup() {
	echo -e "Setting up neovim config..."

	timestamp=$(date +"%Y%m%d-%H:%M:%S")

	if [ -f "$HOME/.config/nvim/init.vim" ]; then
		log "Making backup of '$HOME/.config/nvim/init.vim' to '$HOME/.config/nvim/init.vim.backup.$timestamp'"
		mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.backup.$timestamp
	fi

	log "Symlinking init.vim..."
	ln -sf "$(PWD)/init.vim" $HOME/.config/nvim/

	log "Setup complete."
}

initialize