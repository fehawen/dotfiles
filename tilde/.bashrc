#!/usr/bin/env bash

#########
# PYWAL #
#########

(cat ~/.cache/wal/sequences &)

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

###########
# EXPORTS #
###########

# GLOBALS

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="chromium"
export LC_ALL=en_US.UTF-8
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# -----------------------------------------------------------------------------

# COLORED MAN PAGES

export LESS_TERMCAP_mb=$'\e[0;32m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;35m'

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# SET PATH

paths=(
  "$HOME/.cargo/bin"
  "$HOME/.yarn/bin"
  "$HOME/.npm-global/bin"
  "$HOME/.local/bin"
  "$HOME/.dotnet/tools"
)

#export PATH=~/.cargo/bin:~/.yarn/bin:~/.npm-global/bin:~/.local/bin:$PATH

# Include desired paths in PATH and export,
# leaving default PATH still intact and preventing duplicates,
# because there's something modifying my path,
# and I can't seem to figure out what...

for p in "${paths[@]}"
do
  case ":$PATH:" in
    *":$p:"*) :;; # already there
    *) PATH="$p:$PATH";;
  esac
done

export PATH="${PATH}"

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

###########
# ALIASES #
###########

alias d='printf "%s\n" ${PWD/#$HOME/"~"}'
alias l="ls -Ap --color=always"
alias la="ls -Ap --width=1 --color=always"
alias las="stat -c '%A %a %n' *" # Show octal permissions
alias vm="nvim"
alias gc="git commit"
alias gcm="git commit -m"
alias gpuom="git push -u origin master"
alias gp="git push"
alias gs="git status"
alias gss="git status -s"
alias glog="git log --graph"
alias gh="cd ~/github/"
alias dot="cd ~/dotfiles/"
alias doc="cd ~/documents/"
alias pro="cd ~/projects/"
alias pks="cd ~/packages/"
alias todoread="cat ~/github/todo/README.md"
alias todoedit="nvim ~/github/todo/README.md"

# -----------------------------------------------------------------------------

glogc() {
  git rev-parse --is-inside-work-tree &> /dev/null || \
    printf '%s\n' "Not a git repository"; return

  total="$(git rev-list --all --count)"
  each="$(git shortlog -s -n -e --all)"

  printf '%s\n%s\n' " Total  ${total}" "${each}"
}

# -----------------------------------------------------------------------------

todopush() {
  pushd "$HOME/github/todo/" && \
  git add . && \
  git commit -m "Bump @ $(date '+%Y/%m/%d %H:%M')" && \
  git push && \
  cd "$(dirs -l -0)" && dirs -c
}

# -----------------------------------------------------------------------------

todopull() {
  pushd "$HOME/github/todo/" && \
  git pull && \
  cd "$(dirs -l -0)" && dirs -c
}

# -----------------------------------------------------------------------------

# Find all files in dirs/subdirs containing search query
hunt() {
  grep \
    --exclude-dir=node_modules \
    --exclude-dir=coverage \
    --exclude-dir=.fusebox \
    --exclude-dir=.next \
    --exclude-dir=dist \
    --exclude-dir=.git \
    -wroni "${1}" . \
    | sort -u \
    | grep -iv "^${1}" \
    | sed "/^$/d" \
    | grep -i --color=always "${1}"
}

# -----------------------------------------------------------------------------

# Find all subdirs/filenames in dirs/subdirs matching query
mark() {
  find . \
    -not -path "*node_modules*" \
    -not -path "*.fusebox*" \
    -not -path "*.next*" \
    -not -path "*dist*" \
    -not -path "*.git*" \
    -iname "*${1}*" \
    | sort -u \
    | grep -i --color=always "${1}"
}

# Change directory to git top level
gitup() {
    cd "$(git rev-parse --show-toplevel 2> /dev/null)" || return
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

##########
# PROMPT #
##########

export PS1="-> "
