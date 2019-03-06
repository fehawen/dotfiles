#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
cyan="$(tput setaf 6)"
bold="$(tput bold)"
reset="$(tput sgr0)"

info() {
	echo "${cyan}$1${reset}"
}

alert() {
	echo "${yellow}$1${reset}"
}

success() {
	echo "${green}$1${reset}"
}

error() {
	echo "${red}$1${reset}"
}

symlink() {
	ln -sfv "$(PWD)/$1" "$HOME/$1" || error "Failed to symlink $1"
}

declare -a includes=(
	.bashrc
	.bash_profile
	.hushlogin
	.chunkwmrc
	.skhdrc
)

initialize() {
	read -r -p "${bold}Install tilde config files? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Installation declined..."
		info "Now exiting."
		exit
	else
		setup
	fi
}

setup() {
	success "Setting up tilde..."

	info "Resetting PATH to avoid duplication."
	PATH=$(getconf PATH)

	info "Checking which shell..."
	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		info "Shell is already set to $SHELL"
	else
		alert "Shell is set to $SHELL"
		info "Changing shell to /bin/bash"
		chsh -s /bin/bash
	fi

	for i in "${includes[@]}"
	do
		symlink "$i"
	done

	success "Done."
}

initialize
