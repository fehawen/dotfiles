#!/bin/bash

###############
### SYMBOLS ###
###############

arrow="›"
# arrow="→"
git_modified="!"
git_added="+"
git_deleted="-"
git_renamed="*"
git_untracked="?"
git_stashed="$"
git_ahead="⬑"
git_behind="⬎"

#######################
### SECTION STYLING ###
#######################

# Conventional solution for new line
newline="
"

# Section colors, symbols and prefixes
prefix_color="$white"

clock_color="$yellow"
clock_icon="$stopwatch_icon"

date_prefix="${prefix_color}on"
date_color="$yellow"
date_icon="$calendar_icon"

battery_prefix="${prefix_color}at"
battery_critical_color="$magenta"
battery_regular_color="$green"

user_prefix="${prefix_color}is"
root_color="$magenta"
user_color="$blue"

dir_prefix="${prefix_color}in"
dir_color="$cyan"

git_prefix="${prefix_color}on"
git_branch_color="$magenta"
git_status_prefix="("
git_status_suffix=")"
git_status_color="$red"

exec_time_color="$green"
exec_time_prefix="${prefix_color}took"

exit_ok_color="$green"
exit_bad_color="$red"
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

# Prints time in hh:mm
clock_section() {
	printf "${clock_color}$(date +%H:%M)"
}

# Prints month and date, e.g. 11 may
date_section() {
	date_format="$(date +%d\ %b)"
	echo -e " ${date_prefix} ${date_color}${date_format}" | tr "[:upper:]" "[:lower:]"
}

# Prints battery percentage, and if on battery or AC power
battery_section() {
	local batt_color=""
	local percentage=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1 2> /dev/null)

	if [[ "$percentage" -ge 20 ]]; then
		batt_color="${battery_regular_color}"
	else
		batt_color="${battery_critical_color}"
	fi

	echo -e " ${battery_prefix}${batt_color} ${percentage}%%"
}

# Prints out user only if we"re root, else prints nothing
user_section() {
	if [[ "$UID" -eq 0 ]]; then
		echo -e " ${user_prefix} ${root_color}$USER"
	else
		echo -e " ${user_prefix} ${user_color}$USER"
	fi
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

	echo -e " ${dir_prefix} ${dir_color}${res}"
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

	if [[ "$behind" -gt 0 ]]; then
		status="${git_behind}${status}"
	fi

	if [[ "$ahead" -gt 0 ]]; then
		status="${git_ahead}${status}"
	fi

	local git_status="${git_prefix} ${git_branch_color}${branch}"

	if [[ "$status" != "" ]]; then
		git_status="${git_status} ${git_status_color}${git_status_prefix}${status}${git_status_suffix}"
	fi

	echo -e " ${git_status}"
}

# Command execution time
# Formatted output as 1d 3h 7m 6s
exec_time_section() {
	(( $timer < 3 )) && return

	local output=""

	local days=$(( $timer / 60 / 60 / 24 ))
	local hours=$(( $timer / 60 / 60 % 24 ))
	local minutes=$(( $timer / 60 % 60 ))
	local seconds=$(( $timer % 60 ))

	(( $days > 0 )) && output="${days}d "
	(( $hours > 0 )) && output="${output}${hours}h "
	(( $minutes > 0 )) && output="${output}${minutes}m "

	output="${output}${seconds}s"

	echo -e " ${exec_time_prefix} ${exec_time_color}${output}"
}

# Show exit status of previous command
exit_code_section() {
	local exit_status

	if [[ "$RETVAL" -eq 0 ]]; then
		exit_status="${exit_ok_color}"
	else
		exit_status="${exit_bad_color}"
	fi

	echo -e "${exit_status}${exit_symbol} "
}

######################
### POINT OF ENTRY ###
######################

# Compose prompt
prompt() {
	RETVAL=$?
	printf "${bold}${italic}$(clock_section)$(date_section)$(battery_section)$(user_section)$(dir_section)$(git_section)$(exec_time_section)${newline}$(exit_code_section)${reset}"
}

# Stop timer for execution duration calculation
PROMPT_COMMAND=timer_stop

# Set PS1
export PS1="\$(prompt)"
