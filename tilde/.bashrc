#!/bin/bash

##############
### THEMES ###
##############

THEME="base_prompt"

##############
### COLORS ###
##############

if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null; then
	tput sgr0 # Reset colors

	bold="\001$(tput bold)\002"
	italic="\001$(tput sitm)\002"
	reset="\001$(tput sgr0)\002"

	black="\001$(tput setaf 0)\002"
	red="\001$(tput setaf 1)\002"
	green="\001$(tput setaf 2)\002"
	yellow="\001$(tput setaf 3)\002"
	blue="\001$(tput setaf 4)\002"
	magenta="\001$(tput setaf 5)\002"
	cyan="\001$(tput setaf 6)\002"
	white="\001$(tput setaf 7)\002"
else
	bold="\e[1m"
	italic="\e[3m"
	reset="\e[0m"

	black="\e[1;30m"
	red="\e[1;31m"
	green="\e[1;32m"
	yellow="\e[1;33m"
	blue="\e[1;34m"
	magenta="\e[1;35m"
	cyan="\e[1;36m"
	white="\e[1;97m"
fi

###################
### THEME SETUP ###
###################

THEMES_DIR="$HOME/.config/prompt"
PROMPT_THEME="$THEMES_DIR/$THEME"

[ -f "$PROMPT_THEME" ] && source "$PROMPT_THEME"

##################
### ALIAS FILE ###
##################

ALIAS_FILE="$THEMES_DIR/aliasrc"

[ -f "$ALIAS_FILE" ] && source "$ALIAS_FILE"

###############
### EXPORTS ###
###############

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export LC_ALL=en_US.UTF-8

# Start X if i3 isn't running, and if on Linux (Arch)
if [[ "$OSTYPE" =~ "linux" ]]; then
	[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
fi

compose_path() {
	local paths=$1
	# Include desired paths in PATH and export, leaving default PATH still intact and preventing duplicates
	for p in "${paths[@]}"
	do
		case ":$PATH:" in
			*":$p:"*) :;; # already there
			*) PATH="$p:$PATH";;
		esac
	done

	export PATH="${PATH}"
}

# Set PATH for macOS
if [[ "$OSTYPE" =~ "darwin" ]]; then
	paths=(
		"${HOME}/.yarn/bin"
		"${HOME}/.local/bin/"
		"${HOME}/.npm-global/bin"
		"${HOME}/Library/Python/3.7/bin"
		"${HOME}/paths/mongodb-osx-x86_64-4.0.3/bin"
	)

	compose_path $paths
fi

# Set PATH for Linux
if [[ "$OSTYPE" =~ "linux" ]]; then
	paths=(
		"${HOME}/.yarn/bin"
		"${HOME}/.npm-global/bin"
	)

	compose_path $paths
fi
