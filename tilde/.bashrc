#!/bin/bash

##############
### THEMES ###
##############

# Avaiable themes:
	# grimm
	# captain
	# industrial

THEME="industrial"

######################
### CUSTOMIZATION ####
######################

# Do case-insensitive completion for e.g. `cd` commands
bind "set completion-ignore-case on"

###############
### ALIASES ###
###############

alias clr="clear"
alias la="ls -1AFG"
alias ls="ls -lAFGh"
alias g+="git add"
alias g-="git rm"
alias gcm="git commit -m"
alias gpuom="git push -u origin master"
alias gpom="git push origin master"
alias gpuo="git push -u origin"
alias gpo="git push origin"
alias gp="git push"
alias gs="git status"
alias gss="git status -s"
alias giff="git diff"
alias glog="gitlog"
alias gitlog="git log --pretty=format:'%n%ar %n%Cred%h %Cblue%an <%ae> %n%Cgreen%s%n' --name-only"
alias gfetch="git fetch"
alias gpull="git pull"
alias gbranch="git branch --list"
alias gbranchr="git branch -r"
alias gbranchv="git branch -v"
alias gcheck="git checkout"
alias gcheckb="git checkout -b"
alias gstash="git stash"
alias gstasha="git stash apply"
alias gstashl="git stash list"
alias gstashd="git stash drop"
alias code="open -a 'Visual Studio Code'"
alias gh="cd ~/Github/"
alias ctags="`brew --prefix`/bin/ctags"
alias repos="cd ~/Github/"
alias dot="cd ~/Dotfiles/"
alias pro="cd ~/projects/"
alias mongorun="mongod --dbpath ~/paths/mongodb-osx-x86_64-4.0.3/data"
alias start-chunkwm="brew services start koekeishiya/formulae/chunkwm"
alias restart-chunkwm="brew services restart koekeishiya/formulae/chunkwm"
alias stop-chunkwm="brew services stop koekeishiya/formulae/chunkwm"
alias start-skhd="brew services start koekeishiya/formulae/skhd"
alias restart-skhd="brew services restart koekeishiya/formulae/skhd"
alias stop-skhd="brew services stop koekeishiya/formulae/skhd"
alias todoread="cat ~/Github/todo/README.md"
alias todoedit="nvim ~/Github/todo/README.md"
alias todopush=push_todos
alias todopull=pull_todos
alias hunt=find_string
alias mark=find_filename

#############
### UTILS ###
#############

push_todos() {
	pushd "$HOME/Github/todo/" && \
	git add . && \
	git commit -m "Bump." && \
	git push && \
	popd
}

pull_todos() {
	pushd "$HOME/Github/todo/" && \
	git pull && \
	popd
}

# Find all files in dirs/subdirs containing search query
find_string() {
	command grep --exclude-dir=node_modules --exclude-dir=.fusebox -wroni "$1" . | sort -u | grep -iv "^$1" | sed "/^$/d" | grep -i --color=always "$1"
}

# Find all filenames in dirs/subdirs matching query
find_filename() {
	command find . -not -path "*node_modules*" -iname "$1" | sort -u | grep -i --color=always "$1"
}

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

THEME+=".sh"
THEMES_DIR="$HOME/.config/prompt"
PROMPT_THEME="$THEMES_DIR/$THEME"

if [ -f $PROMPT_THEME ];then
	source $PROMPT_THEME
fi

###################
### ENV EXPORTS ###
###################

paths=(
	"${HOME}/.local/bin/"
	"${HOME}/.npm-global/bin"
	"${HOME}/Library/Python/3.7/bin"
	"${HOME}/paths/mongodb-osx-x86_64-4.0.3/bin"
)

# Include desired paths in PATH and export, leaving default PATH still intact and preventing duplicates
for p in "${paths[@]}"
do
	case ":$PATH:" in
		*":$p:"*) :;; # already there
		*) PATH="$p:$PATH";;
	esac
done

# Set path
export PATH="${PATH}"

# Set default editor
export EDITOR="/usr/local/bin/nvim"
