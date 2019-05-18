#!/bin/bash

###############
### SYMBOLS ###
###############

octopus_icon="  "
system_icon="  "
lightning_icon="  "
deleted_icon="  "
question_icon="  "
cog_icon="  "
cogs_icon="  "
branch_icon="  "
tag_icon="  "
puzzle_icon="  "
pen_icon="  "
plus_icon="  "
home_icon="  "
folder_icon="   "
cross_icon="  "
check_icon="  "
calendar_icon="  "
hourglass_icon=" "
stopwatch_icon="  "
bag_icon="  "
floppy_icon="  "
paperclip_icon="  "
patch_icon="  "
ahead_icon="   "
behind_icon="   "
battery_panic_icon="  "
battery_critical_icon="  "
battery_low_icon="  "
battery_half_icon="  "
battery_full_icon="  "
battery_charging_icon="  "

git_modified="$pen_icon"
git_added="$plus_icon"
git_deleted="$deleted_icon"
git_renamed="$patch_icon"
git_untracked="$question_icon"
git_stashed="$floppy_icon"
git_ahead="$ahead_icon"
git_behind="$git_behind"

#######################
### SECTION STYLING ###
#######################

# Conventional solution for new line
newline="
"

# Section colors, symbols and prefixes
clock_color="$white"
clock_icon="$stopwatch_icon"

date_color="$white"
date_icon="$calendar_icon"

battery_panic_color="$red"
battery_critical_color="$red"
battery_low_color="$yellow"
battery_half_color="$cyan"
battery_full_color="$green"
battery_charging_color="$white"

dir_color="$cyan"
dir_home_icon="$home_icon"
dir_folder_icon="$folder_icon"

root_color="$red"
user_icon="$system_icon"
user_color="$yellow"

git_branch_color="$magenta"
git_branch_icon="$branch_icon"
git_status_color="$red"

exec_time_color="$white"
exec_time_icon="$hourglass_icon"

exit_ok_color="$green"
exit_ok_icon="$check_icon"
exit_bad_color="$red"
exit_bad_icon="$cross_icon"

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
	echo -e "${clock_color}${clock_icon}`date +"%H:%M"`"
}

# Prints month and date, e.g. 11 may
date_section() {
	date_format="$(date +%d\ %b)"
	echo -e " ${date_color}${date_icon}${date_format}" | tr "[:upper:]" "[:lower:]"
}

# Prints battery percentage, and if on battery or AC power
battery_section() {
	local output=""
	local charging=$(pmset -g ps | head -1 2> /dev/null)
	local percentage=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1 2> /dev/null)
	local battery_level=$(pmset -g batt | grep -Eo "\d+%" 2> /dev/null)

	if [[ "$charging" =~ "AC Power" ]]; then
		output="${battery_charging_color}${battery_charging_icon}"
	elif [[ "$percentage" -ge 75 ]]; then
		output="${battery_full_color}${battery_full_icon}"
	elif [[ "$percentage" -ge 50 ]]; then
		output="${battery_half_color}${battery_half_icon}"
	elif [[ "$percentage" -ge 25 ]]; then
		output="${battery_low_color}${battery_low_icon}"
	elif [[ "$percentage" -ge 10 ]]; then
		output="${battery_critical_color}${battery_critical_icon}"
	else
		output="${battery_panic_color}${battery_panic_icon}"
	fi

	echo -e " ${output}${battery_level}"
}

# Prints out user only if we"re root, else prints nothing
user_section() {
	if [[ "$UID" -eq 0 ]]; then
		echo -e "${root_color}${user_icon}$USER"
	else
		echo -e "${user_color}${user_icon}$USER"
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
		prefix="${dir_home_icon}~/"
	else
		prefix="${dir_folder_icon}"
	fi

	if [[ "$(PWD)" == "$HOME" ]]; then
		res="${dir_home_icon}~"
	else
		res="${prefix}${get_dir}"
	fi

	echo -e " ${dir_color}${res}"
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

	local git_status="${git_branch_color}${git_branch_icon}${branch}"

	if [[ "$status" != "" ]]; then
		git_status="${git_status} ${git_status_color}${status}"
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

	echo -e " ${exec_time_color}${exec_time_icon}${output}"
}

# Show exit status of previous command
exit_code_section() {
	local exit_status

	if [[ "$RETVAL" -eq 0 ]]; then
		exit_status="${exit_ok_color}${exit_ok_icon}"
	else
		exit_status="${exit_bad_color}${exit_bad_icon}"
	fi

	echo -e "${exit_status} "
}

######################
### POINT OF ENTRY ###
######################

# Compose prompt
prompt() {
	RETVAL=$?
	echo -e "${newline}${bold}${octopus_icon}$(clock_section)$(date_section)$(battery_section)${newline}$(user_section)$(dir_section)$(git_section)$(exec_time_section)${newline}$(exit_code_section)${reset}"
}

# Stop timer for execution duration calculation
PROMPT_COMMAND=timer_stop

# Set PS1
export PS1="\$(prompt)"
