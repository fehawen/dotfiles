#!/usr/bin/env bash

# exports

export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="chromium"
export LC_ALL=en_US.UTF-8
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FFF_CD_ON_EXIT=1
export FFF_HIDDEN=1
export CPR_LIB=~/github/hokusai

# -----------------------------------------------------------------------------

# colored man pages

export LESS_TERMCAP_mb=$'\e[0;32m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;35m'

# -----------------------------------------------------------------------------

# set path

paths=(
    "$HOME/bin"
    "$HOME/.npm-global/bin"
    "$HOME/.yarn/bin"
    "$HOME/.dotnet/tools"
    "$HOME/.cargo/bin"
)

# export PATH=~/.cargo/bin:~/.yarn/bin:~/.npm-global/bin:~/.local/bin:$PATH:

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

# aliases

alias d='printf "%s\n" ${PWD/#$HOME/"~"}'
alias l="ls -AF --color=always"
alias la="ls -AF1 --color=always"
alias las="stat -c '%A %a %n' *" # Show octal permissions
alias ll="ls -lAFGh --color=always"
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
alias todoedit="vim ~/github/todo/README.md"

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
    (
        cd "$HOME/github/todo/" && \
        git add . && \
        git commit -m "Bump @ $(date '+%Y/%m/%d %H:%M')" && \
        git push
    )
}

# -----------------------------------------------------------------------------

todopull() {
    (cd "$HOME/github/todo/" && git pull)
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

# -----------------------------------------------------------------------------

# Change directory to git top level
gt() {
    cd "$(git rev-parse --show-toplevel 2> /dev/null)" || return
}

# -----------------------------------------------------------------------------

# fff and cd on exit
f() {
    fff "$@"
    cd "$(cat "${HOME}/.cache/fff/.fff_d")" || return
}

# -----------------------------------------------------------------------------

# prompt

export PS1="-> "

# -----------------------------------------------------------------------------

# cpr

cpr revive
