autoload -Uz vcs_info
autoload -U colors && colors

precmd() {
	vcs_info
}

# red="%{$fg[red]%}"
# white="%{$fg[white]%}"
# cyan="%{$fg[cyan]%}"
# blue="%{$fg[blue]%}"
# magenta="%{$fg[magenta]%}"
# yellow="%{$fg[yellow]%}"
# reset="%{$reset_color%}"

COLS=(
	BLACK
	RED
	GREEN
	YELLOW
	BLUE
	MAGENTA
	CYAN
	WHITE
)

duration() {
	local T=$1
	local D=$((T/60/60/24))
	local H=$((T/60/60%24))
	local M=$((T/60%60))
	local S=$((T%60))
	[[ $D > 0 ]] && printf '%dd ' $D
	[[ $H > 0 ]] && printf '%dh ' $H
	[[ $M > 0 ]] && printf '%dm ' $M
	printf '%ds' $S
}

# TODO implement: https://github.com/denysdovhan/spaceship-prompt/blob/master/sections/git_branch.zsh

for COLOR in $COLS[@]; do
	eval $COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='$reset_color'

compose_prompt() {

	local output

	if [[ "$vcs_info_msg_0_" = "" ]]; then
		output="${MAGENTA}${vcs_info_msg_0_} "
	else
		output="${CYAN}%F{3}%3~ "
	fi

	output+="${WHITE}$ "

	echo "$output"
}

setopt prompt_subst
PROMPT="$(compose_prompt)"
RPROMPT="${BLUE}%D{%T}"

# fpath=( "$HOME/.zfunctions" $fpath )