#!/bin/bash

##############
### THEMES ###
##############

declare THEME="base_prompt"

##############
### COLORS ###
##############

if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null; then
	tput sgr0 # Reset colors

	declare bold="\001$(tput bold)\002"
	declare italic="\001$(tput sitm)\002"
	declare reset="\001$(tput sgr0)\002"

	declare black="\001$(tput setaf 0)\002"
	declare red="\001$(tput setaf 1)\002"
	declare green="\001$(tput setaf 2)\002"
	declare yellow="\001$(tput setaf 3)\002"
	declare blue="\001$(tput setaf 4)\002"
	declare magenta="\001$(tput setaf 5)\002"
	declare cyan="\001$(tput setaf 6)\002"
	declare white="\001$(tput setaf 7)\002"
else
	declare bold="\e[1m"
	declare italic="\e[3m"
	declare reset="\e[0m"

	declare black="\e[1;30m"
	declare red="\e[1;31m"
	declare green="\e[1;32m"
	declare yellow="\e[1;33m"
	declare blue="\e[1;34m"
	declare magenta="\e[1;35m"
	declare cyan="\e[1;36m"
	declare white="\e[1;97m"
fi

###################
### THEME SETUP ###
###################

declare THEMES_DIR="$HOME/.config/prompt"
declare PROMPT_THEME="$THEMES_DIR/$THEME"

[[ -f "$PROMPT_THEME" ]] && source "$PROMPT_THEME"

##################
### ALIAS FILE ###
##################

declare ALIAS_FILE="$THEMES_DIR/aliasrc"

[[ -f "$ALIAS_FILE" ]] && source "$ALIAS_FILE"

###############
### EXPORTS ###
###############

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="chromium"
export LC_ALL=en_US.UTF-8

# Colored man pages
export LESS_TERMCAP_mb=$'\e[0;32m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;35m'

# Start X if i3 isn't running, and if on Linux (Arch)
if [[ "$OSTYPE" =~ "linux" ]]; then
	[[ "$(tty)" = "/dev/tty1" ]] && ! pgrep -x i3 >/dev/null && exec startx
fi

compose_path() {
	declare -a paths=($@)
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
	declare -a paths=(
		"${HOME}/.yarn/bin"
		"${HOME}/.local/bin/"
		"${HOME}/.npm-global/bin"
		"${HOME}/Library/Python/3.7/bin"
		"${HOME}/paths/mongodb-osx-x86_64-4.0.3/bin"
	)

	compose_path ${paths[@]}
fi

# Set PATH for Linux
if [[ "$OSTYPE" =~ "linux" ]]; then
	declare -a paths=(
		"${HOME}/.yarn/bin"
		"${HOME}/.npm-global/bin"
	)

	compose_path ${paths[@]}
fi
