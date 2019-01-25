#!/bin/bash

alias clr='clear'
alias ll='ls -1 -F -G'
alias la='ls -1A -F -G'
alias las='ls -lAh -F -G'
alias g+='git add'
alias g-='git rm'
alias gcm='git commit -m'
alias gpuom='git push -u origin master'
alias gpom='git push origin master'
alias gpuo='git push -u origin'
alias gpo='git push origin'
alias gp='git push'
alias gs='git status'
alias gss='git status -s'
alias giff='git diff'
alias glog='git log'
alias gfetch='git fetch'
alias gpull='git pull'
alias gbranch='git branch --list'
alias gbranchr='git branch -r'
alias gbranchv='git branch -v'
alias gcheck='git checkout'
alias gcheckb='git checkout -b'
alias code='open -a "Visual Studio Code"'
alias files='cd ~/files/'
alias repos='cd ~/repos/'
alias projects='cd ~/projects'
alias mongorun='mongod --dbpath ~/paths/mongodb-osx-x86_64-4.0.3/data'
alias gconf=git_config

git_config() {

	command git config user.name $1 && git config user.email $2

}

black="\001$(tput setaf 0)\002"
red="\001$(tput setaf 1)\002"
green="\001$(tput setaf 2)\002"
yellow="\001$(tput setaf 3)\002"
blue="\001$(tput setaf 4)\002"
magenta="\001$(tput setaf 5)\002"
cyan="\001$(tput setaf 6)\002"
white="\001$(tput setaf 7)\002"
grey="\001$(tput setaf 8)\002"
bold="\001$(tput bold)\002"
underline_begin="\001$(tput smul)\002"
underline_end="\001$(tput rmul)\002"
reset="\001$(tput sgr0)\002"

icon_gitbranch=""
icon_prompt="→"
icon_files="◆"
icon_node="●"

git_modified="!"
git_added="+"
git_deleted="-"
git_renamed="*"
git_untracked="?"
git_stashed="$"
git_ahead="↑"
git_behind="↓"

bracket_prefix="["
bracket_suffix="]"

newline='
'

timer_start() {

	timer=${timer:-$SECONDS}

}

timer_stop() {

	timer_show=$(($SECONDS - $timer))

	unset timer

}

trap timer_start DEBUG

command_exists() {

	command -v $1 > /dev/null 2>&1

}

is_git_repository() {

	command git rev-parse --is-inside-work-tree &> /dev/null

}

user_section() {

	if [[ $UID -eq 0 ]]; then
		printf "${red}$USER ${white}in "
	fi

}

dir_section() {

	local dir
	local get_dir=${PWD##*/}

	if [[ $(PWD) == $HOME ]]; then
			dir="~"
	elif [[ $(PWD) == "$HOME/$get_dir" ]]; then
			dir="~/$get_dir"
	else
		if is_git_repository; then
			local git_root=$(git rev-parse --show-toplevel)
			if [[ $(PWD) == $git_root ]]; then
				dir="../$get_dir"
			else
				dir="../${underline_begin}$get_dir${underline_end}"
			fi
		else
			dir="../$get_dir"
		fi
	fi

	printf "${cyan}$dir "

}

dir_content_section() {

	[[ $(PWD) == $HOME ]] && return

	local subdirs=$(ls -lA | grep -c ^d)
	local files=$(ls -lA | grep -c ^-)
	local content

	if [[ $subdirs == 0 && $files == 0 ]]; then
		content="empty"
	else
		content="${subdirs}.${files}"
	fi

	printf "${white}at ${yellow}${icon_files} ${content} "

}

git_section() {

	is_git_repository || return

	local status=""
	local index=$(command git status --porcelain -b 2> /dev/null)
	local branch=$(git symbolic-ref --short HEAD 2> /dev/null)
	local branch_ahead branch_behind

	if $(echo "$index" | command grep -E '^[MARCDU ]D ' &> /dev/null); then
		status="${git_deleted}${status}"
	elif $(echo "$index" | command grep -E '^D[ UM] ' &> /dev/null); then
		status="${git_deleted}${status}"
	fi

	if $(echo "$index" | command grep -E '^A[ MDAU] ' &> /dev/null); then
		status="${git_added}${status}"
	elif $(echo "$index" | command grep -E '^M[ MD] ' &> /dev/null); then
		status="${git_added}${status}"
	elif $(echo "$index" | command grep -E '^UA' &> /dev/null); then
		status="${git_added}${status}"
	fi

	if $(echo "$index" | command grep -E '^R[ MD] ' &> /dev/null); then
		status="${git_renamed}${status}"
	fi

	if $(command git rev-parse --verify refs/stash > /dev/null 2>&1); then
		status="${git_stashed}${status}"
	fi

	if $(echo "$index" | command grep -E '^\?\? ' &> /dev/null); then
		status="${git_untracked}${status}"
	fi

	if $(echo "$index" | command grep -E '^[ MARC]M ' &> /dev/null); then
		status="${git_modified}${status}"
	fi

	local behind=$(git rev-list --left-only --count @'{u}'...HEAD 2> /dev/null)

	if [[ $behind -gt 0 ]]; then
		status="${git_behind}${status}"
	fi

	local ahead=$(git rev-list --left-only --count HEAD...@'{u}' 2> /dev/null)

	if [[ $ahead -gt 0 ]]; then
		status="${git_ahead}${status}"
	fi

	local git_status="${white}on ${magenta}${icon_gitbranch} ${branch} "

	if [[ $status != "" ]]; then
		git_status="${git_status}${red}${bracket_prefix}${status}${bracket_suffix} "
	fi

	printf "${git_status}"

}

node_section() {

	is_git_repository || return

	local git_root=$(git rev-parse --show-toplevel)

	[[ -f ${git_root}/package.json || -d ${git_root}/node_modules || -f package.json || -d node_modules ]] || return

	local node_version=$(node -v 2> /dev/null)

	if command_exists node; then
		printf "${white}via ${green}${icon_node} ${node_version} "
	fi

}

exec_time_section() {

	local suffix duration timer_limit=2

	if [[ $timer_show -ge $timer_limit ]]; then
		if [[ $timer_show -le 60 ]]; then
			suffix="sec"
			duration=${timer_show}
		elif [[ $timer_show -gt 60 && $timer_show -lt 3600 ]]; then
			suffix="min"
			duration=$(printf %.1f "$((10 * $timer_show / 60))e-1")
		elif [[ $timer_show -ge 3600 ]]; then
			suffix="hrs"
			duration=$(printf %.1f "$((10 * $timer_show / 3600))e-1")
		elif [[ $timer_show -ge 86400 ]]; then
			suffix="days"
			duration=$(printf %.1f "$((10 * $timer_show / 86400))e-1")
		fi
		printf "${white}took ${green}${duration} ${suffix}"
	fi

}

exit_section() {

	local exit_status

	if [[ $RETVAL -eq 0 ]]; then 
		exit_status="${green}"
	else
		exit_status="${red}"
	fi

	printf "${reset}${exit_status}${icon_prompt} "

}

set_prompt() {

	RETVAL=$?

	printf "${newline}${bold}$(user_section)$(dir_section)$(dir_content_section)$(git_section)$(node_section)$(exec_time_section)${newline}$(exit_section)${reset}"

}

PROMPT_COMMAND=timer_stop

PS1="\$(set_prompt)"

PATH="~/.npm-global/bin:$PATH"