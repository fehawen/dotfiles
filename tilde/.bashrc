#!/bin/bash

######################
### CUSTOMIZATION ####
######################

bind "set completion-ignore-case on"

#######################
###### VARIABLES ######
#######################

# Aliases
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
alias glog="git log --pretty=format:'%n%Cred%ar %n%Creset%h %Cblue%an <%ae> %n%Cgreen%s' --name-only"
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
alias bashrc="source ~/.bashrc"
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
alias hunt=find_exact_match

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

# Search function, called on with alias "hunt" -- e.g. hunt "const" to find all occurences of "const" in dir w/ subdirs
find_exact_match() {
	command grep --exclude-dir=node_modules -wroni "$1" . | sort -u | grep -iv "^$1" | sed "/^$/d" | grep -i --color=always "$1"
}

# Colors
black="\001$(tput setaf 0)\002"
bright_black="\001$(tput setaf 8)\002"

red="\001$(tput setaf 1)\002"
bright_red="\001$(tput setaf 9)\002"

green="\001$(tput setaf 2)\002"
bright_green="\001$(tput setaf 10)\002"

yellow="\001$(tput setaf 3)\002"
bright_yellow="\001$(tput setaf 11)\002"

blue="\001$(tput setaf 4)\002"
bright_blue="\001$(tput setaf 12)\002"

magenta="\001$(tput setaf 5)\002"
bright_magenta="\001$(tput setaf 13)\002"

cyan="\001$(tput setaf 6)\002"
bright_cyan="\001$(tput setaf 14)\002"

white="\001$(tput setaf 7)\002"
bright_white="\001$(tput setaf 15)\002"

bold="\001$(tput bold)\002"
italic="\e[3m"
reset="\001$(tput sgr0)\002"

# Symbols
arrow="→"
git_modified="!"
git_added="+"
git_deleted="-"
git_renamed="*"
git_untracked="?"
git_stashed="$"
git_uneven="¿"

# Conventional solution for new line
newline="
"

# Section colors, symbols and prefixes - change to your liking!
user_is_root_color="$red"

dir_color="$bright_cyan"
dir_prefix="at"
dir_is_git_repo_subfolder_symbol="$arrow"

dir_content_color="$bright_blue"
dir_content_prefix_color="$white"
dir_content_prefix="at"
dir_content_separator="."

git_branch_color="$bright_magenta"
git_branch_prefix_color="$white"
git_branch_prefix="on"

git_status_color="$red"
git_status_prefix="["
git_status_suffix="]"

date_suffix="in"
date_suffix_color="$white"
date_color="$bright_blue"

exec_time_color="$green"
exec_time_prefix_color="$white"
exec_time_prefix="took"

exit_color_ok=$green
exit_color_bad=$red
exit_symbol=$arrow

######################
###### SECTIONS ######
######################

# Timer for calculating execution time
timer_start() {
	timer=${timer:-$SECONDS}
}

timer_stop() {
	timer_show=$(($SECONDS - $timer))
	unset timer
}

trap timer_start DEBUG

# Check if command exists, without printing error if it doesn"t
command_exists() {
	command -v $1 > /dev/null 2>&1
}

# Check if we"re in a git repository, without printing error if we aren"t
is_git_repository() {
	command git rev-parse --is-inside-work-tree &> /dev/null
}

# Prints out user only if we"re root, else prints nothing
user_section() {
	if [[ "$UID" -eq 0 ]]; then
		printf "${user_is_root_color}$USER ${white}${dir_prefix} "
	fi
}

# Prints time in hh:mm
date_section() {
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

# Get execution time of previous command and display in seconds, minutes, hours or days
exec_time_section() {
	local suffix duration timer_limit=2
	if [[ "$timer_show" -ge "$timer_limit" ]]; then
		if [[ "$timer_show" -le 60 ]]; then
			suffix="sec"
			duration="${timer_show}"
		elif [[ "$timer_show" -gt 60 && "$timer_show" -lt 3600 ]]; then
			suffix="min"
			duration="$(printf %.1f "$((10 * $timer_show / 60))e-1")"
		elif [[ "$timer_show" -ge 3600 ]]; then
			suffix="hrs"
			duration="$(printf %.1f "$((10 * $timer_show / 3600))e-1")"
		elif [[ "$timer_show" -ge 86400 ]]; then
			suffix="days"
			duration="$(printf %.1f "$((10 * $timer_show / 86400))e-1")"
		fi
		printf "${exec_time_prefix_color}${exec_time_prefix} ${exec_time_color}${duration} ${suffix}"
	fi
}


# Show retval of previous command, where `0` is OK and any other number is BAD
exit_section() {
	local exit_status

	if [[ "$RETVAL" -eq 0 ]]; then
		exit_status="${exit_color_ok}"
	else
		exit_status="${exit_color_bad}"
	fi

	printf "${exit_status}${exit_symbol} "
}

############################
###### POINT OF ENTRY ######
############################

# Compose prompt
compose_prompt() {
	RETVAL=$?
	printf "${bold}${italic}$(date_section)$(user_section)$(dir_section)$(git_section)$(exec_time_section)${newline}$(exit_section)${reset}"
}

# Stop timer for execution time calculation
PROMPT_COMMAND=timer_stop

# Export prompt composition to PS1
PS1="\$(compose_prompt)"

# Include desired paths in PATH and export, leaving default PATH still intact
PATH="${PATH}:${HOME}/.npm-global/bin:${HOME}/Library/Python/3.7/bin:${HOME}/.local/bin/"
