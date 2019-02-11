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
	read -r -p "${cyan}Setup bash prompt? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Setup declined..."
		error "Now exiting."
		exit
	else
		setup
	fi
}

setup() {
	echo -e "Setting up bash prompt..."

	timestamp=$(date +"%Y%m%d-%H:%M:%S")

	if [ -f "$HOME/.bashrc" ]; then
		log "Making backup of '$HOME/.bashrc' to '$HOME/.bashrc.backup.$timestamp'"
		mv $HOME/.bashrc $HOME/.bashrc.backup.$timestamp
	fi

	if [ -f "$HOME/.bash_profile" ]; then
		log "Making backup of '$HOME/.bash_profile' to '$HOME/.bash_profile.backup.$timestamp'"
		mv $HOME/.bash_profile $HOME/.bash_profile.backup.$timestamp
	fi

	log "Symlinking .bashrc..."
	ln -sf "$(PWD)/.bashrc" $HOME

	log "Symlinking .bash_profile..."
	ln -sf "$(PWD)/.bash_profile" $HOME

	log "Symlinking .hushlogin for muted terminal login message..."
	ln -sf "$(PWD)/.hushlogin" $HOME

	echo "Checking which shell..."
	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		log "Shell is already set to $SHELL"
	else
		log "Shell is set to $SHELL"
		log "Changing shell to /bin/bash"
		chsh -s /bin/bash
	fi

	log "Setup complete."
	echo -e "Enter ${cyan}source ~/.bashrc${reset} to reload prompt"
}

initialize