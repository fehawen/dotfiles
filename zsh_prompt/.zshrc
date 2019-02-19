autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' enable git svn

precmd() {
	vcs_info
}

zstyle ':vcs_info:git*' formats "%{$fg[cyan]%}%r/%S %{$fg[white]%}on %{$fg[magenta]%}%b (%a) %m%u%c%{$reset_color%} "

setopt prompt_subst
PROMPT='${vcs_info_msg_0_}%# '
