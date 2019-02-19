autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' enable git svn

precmd() {
	vcs_info
}

zstyle ':vcs_info:git*' formats "%{$fg[cyan]%}%r/%S %{$fg[white]%}on %{$fg[magenta]%}%b (%a) %m%u%c%{$reset_color%} "

# zstyle ':vcs_info:*' actionformats \ 
#     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats       \ 
#     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

setopt prompt_subst
PROMPT='%F{3}%3~ ${vcs_info_msg_0_}%# '
# PS1='%F{3}%3~ '
# PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '