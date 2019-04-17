#!/bin/bash

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
alias show=cat_file

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

cat_file() {
	printf "\n"
	cat -n "$1"
	printf "\n"
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

###############
### SYMBOLS ###
###############

arrow="❯"
git_modified="!"
git_added="+"
git_deleted="-"
git_renamed="*"
git_untracked="?"
git_stashed="$"
git_uneven="¿"

#####################
### SECTION  ###
#####################

# Conventional solution for new line
newline="
"

# Section colors, symbols and prefixes
root_color="$red"
root_suffix="at"

date_suffix="in"
date_suffix_color="$white"
date_color="$blue"

dir_color="$cyan"

git_branch_color="$magenta"
git_branch_prefix_color="$white"
git_branch_prefix="on"

git_status_color="$red"
git_status_prefix="["
git_status_suffix="]"

exec_time_color="$yellow"
exec_time_prefix_color="$white"
exec_time_prefix="took"

exit_color_ok="$green"
exit_color_bad="$red"
exit_symbol="$arrow"

#######################
### PROMPT SECTIONS ###
#######################

# Check if command exists, without printing error if it doesn"t
command_exists() {
	command -v $1 > /dev/null 2>&1
}

# Check if we"re in a git repository, without printing error if we aren"t
is_git_repository() {
	command git rev-parse --is-inside-work-tree &> /dev/null
}

timer_start() {
	start_time=${start_time:-$SECONDS}
}

timer_stop() {
	timer=$(($SECONDS - $start_time))
	unset start_time
}

trap timer_start DEBUG

# Prints out user only if we"re root, else prints nothing
user_section() {
	if [[ "$UID" -eq 0 ]]; then
		printf "${root_color}$USER ${white}${root_suffix} "
	fi
}

# Prints time in hh:mm
clock_section() {
	[[ "$(PWD)" == "$HOME" ]] && return
	printf "${date_color}`date +"%H:%M"` ${date_suffix_color}${date_suffix} "
}

# Prints out current working directory with varying prefix,
# depending if we"re in $HOME/dir or $HOME/.../dir, or
# if we"re in a git repo, or in a git repo subdirectory
dir_section() {
	local get_dir="${PWD##*/}"
	local prefix res

	prefix=""
	res=""

	if [[ "$(PWD)" == "$HOME/$get_dir" ]]; then
		prefix="~/"
	else
		prefix=""
	fi

	if [[ "$(PWD)" == "$HOME" ]]; then
		res="~"
	else
		res="${prefix}${get_dir}"
	fi

	printf "${dir_color}${res} "
}

# Show current Git branch, and if branch isn"t clean show status
git_section() {
	is_git_repository || return

	local status=""
	local index="$(git status --porcelain -b 2> /dev/null)"
	local branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null)"
	local branch_ahead branch_behind

	if $(echo "$index" | command grep -E "^[MARCDU ]D " &> /dev/null); then
		status="${git_deleted}${status}"
	elif $(echo "$index" | command grep -E "^D[ UM] " &> /dev/null); then
		status="${git_deleted}${status}"
	fi

	if $(echo "$index" | command grep -E "^A[ MDAU] " &> /dev/null); then
		status="${git_added}${status}"
	elif $(echo "$index" | command grep -E "^M[ MD] " &> /dev/null); then
		status="${git_added}${status}"
	elif $(echo "$index" | command grep -E "^UA" &> /dev/null); then
		status="${git_added}${status}"
	fi

	if $(echo "$index" | command grep -E "^R[ MD] " &> /dev/null); then
		status="${git_renamed}${status}"
	fi

	if $(command git rev-parse --verify refs/stash > /dev/null 2>&1); then
		status="${git_stashed}${status}"
	fi

	if $(echo "$index" | command grep -E "^\?\? " &> /dev/null); then
		status="${git_untracked}${status}"
	fi

	if $(echo "$index" | command grep -E "^[ MARC]M " &> /dev/null); then
		status="${git_modified}${status}"
	fi

	local behind="$(git rev-list --left-only --count @"{u}"...HEAD 2> /dev/null)"
	local ahead="$(git rev-list --left-only --count HEAD...@"{u}" 2> /dev/null)"

	if [[ "$behind" -gt 0 || "$ahead" -gt 0 ]]; then
		status="${git_uneven}${status}"
	fi

	local git_status="${git_branch_prefix_color}${git_branch_prefix} ${git_branch_color}${branch} "

	if [[ "$status" != "" ]]; then
		git_status="${git_status}${git_status_color}${git_status_prefix}${status}${git_status_suffix} "
	fi

	printf "${git_status}"
}

# Command execution time
# Formatted output as 1d 3h 7m 6s
exec_time_section() {
	(( $timer < 3 )) && return

	local output

	local days=$(( $timer / 60 / 60 / 24 ))
	local hours=$(( $timer / 60 / 60 % 24 ))
	local minutes=$(( $timer / 60 % 60 ))
	local seconds=$(( $timer % 60 ))

	(( $days > 0 )) && output="${days}d "
	(( $hours > 0 )) && output="${output}${hours}h "
	(( $minutes > 0 )) && output="${output}${minutes}m "

	output="${output}${seconds}s "

	printf "${exec_time_prefix_color}${exec_time_prefix} ${exec_time_color}${output}"
}

# Show exit status of previous command
exit_code_section() {
	local exit_status

	if [[ "$RETVAL" -eq 0 ]]; then
		exit_status="${exit_color_ok}"
	else
		exit_status="${exit_color_bad}"
	fi

	printf "${exit_status}${exit_symbol} "
}

######################
### POINT OF ENTRY ###
######################

# Compose prompt
prompt() {
	RETVAL=$?
	printf "\r${bold}$(user_section)$(clock_section)$(dir_section)$(git_section)$(exec_time_section)${newline}$(exit_code_section)${reset}"
}

# Stop timer for execution time
PROMPT_COMMAND=timer_stop

export PS1="\$(prompt)"

###################
### ENV EXPORTS ###
###################

# Include desired paths in PATH and export, leaving default PATH still intact
export PATH="${HOME}/.npm-global/bin:${HOME}/Library/Python/3.7/bin:${HOME}/.local/bin/:${PATH}"

# Set default editor
export EDITOR="/usr/local/bin/nvim"
