#!/usr/bin/env bash

#########
# PYWAL #
#########

(cat ~/.cache/wal/sequences &)

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

##########
# COLORS #
##########

export newline="\n"

export bold="\[\e[1m\]"
export italic="\[\e[3m\]"
export reset="\[\e[0m\]"

export black="\[\e[1;90m\]"
export red="\[\e[1;31m\]"
export green="\[\e[1;32m\]"
export yellow="\[\e[1;33m\]"
export blue="\[\e[1;34m\]"
export magenta="\[\e[1;35m\]"
export cyan="\[\e[1;36m\]"
export white="\[\e[1;97m\]"

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

###########
# EXPORTS #
###########

# GLOBALS

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="chromium"
export LC_ALL=en_US.UTF-8

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
)

# Include desired paths in PATH and export, leaving default PATH still intact and preventing duplicates
for p in "${paths[@]}"
do
  case ":$PATH:" in
    *":$p:"*) :;; # already there
    *) PATH="$p:$PATH";;
  esac
done

export PATH="${PATH}"

# Or just keep it simple
# export PATH=~/some/path/bin:~/some/path/bin:$PATH

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

###########
# ALIASES #
###########

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias clr="clear"
alias la="ls -AFGhl"
alias las="stat -c '%A %a %n' *" # Show octal permissions
alias gc="git commit"
alias gcm="git commit -m"
alias gpuom="git push -u origin master"
alias gpom="git push origin master"
alias gpuo="git push -u origin"
alias gpo="git push origin"
alias gp="git push"
alias gs="git status"
alias gss="git status -s"
alias giff="git diff"
alias glog="git log --graph"
alias code="open -a 'Visual Studio Code'"
alias gh="cd ~/github/"
alias repos="cd ~/github/"
alias dot="cd ~/dotfiles/"
alias pro="cd ~/projects/"
alias aur="cd ~/packages/"
alias todoread="cat ~/github/todo/README.md"
alias todoedit="nvim ~/github/todo/README.md"
alias rr="ranger"
alias vm="nvim"
alias icat="kitty +kitten icat"
alias screenshot="scrot ~/pictures/screenshots/%Y-%m-%d-%T-screenshot.png -d 5"

# -----------------------------------------------------------------------------

glogc() {
  is_git_repository || return

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
    -wroni "${1}" . | sort -u | grep -iv "^${1}" | sed "/^$/d" | grep -i --color=always "${1}"
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
    -iname "*${1}*" | sort -u | grep -i --color=always "${1}"
}

# -----------------------------------------------------------------------------

# Clone a Github by providing arguments:
# 1: username
# 2: repository
clone() {
  if [ $# -lt 2 ]; then
    echo "Too few arguments provided"
    echo "Please provide:"
    echo "ARG 1: username"
    echo "ARG 2: repository"
  fi

  #git clone https://github.com/"$1"/"$2".git
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

##########
# PROMPT #
##########

# VARIABLES

git_dirty_symbol="?"
git_stashed_symbol="!"
prompt_symbol="$"

dir_color="$cyan"
git_branch_color="$magenta"
git_dirty_color="$red"
exit_ok_color="$white"
exit_bad_color="$black"

# -----------------------------------------------------------------------------

# HELPERS

is_git_repository() {
  git rev-parse --is-inside-work-tree &> /dev/null
}

# -----------------------------------------------------------------------------

# MODULES

dir_module() {
  PS1+="${dir_color}\W"
}

# -----------------------------------------------------------------------------

git_branch_module() {
  is_git_repository || return

  branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

  PS1+=" ${git_branch_color}${branch}"
}

# -----------------------------------------------------------------------------

git_dirty_module() {
  is_git_repository || return

  if \
    [[ "$(git status -s)" != "" ]] || \
    [[ "$(git rev-list --left-only --count HEAD...@"{u}" 2> /dev/null)" -gt 0 ]] || \
    [[ "$(git rev-list --left-only --count @"{u}"...HEAD 2> /dev/null)" -gt 0 ]]; then
    status="${git_dirty_symbol}"
  elif [[ -n "$(git stash list 2> /dev/null)" ]]; then
    status="${git_stashed_symbol}"
  else
    status=""
  fi

  if [[ "${status}" != "" ]]; then
    PS1+=" ${git_dirty_color}${status}"
  fi
}

# -----------------------------------------------------------------------------

exit_code_module() {
  if [[ "$RETVAL" -eq 0 ]]; then
    exit_status="${exit_ok_color}"
  else
    exit_status="${exit_bad_color}"
  fi

  PS1+=" ${exit_status}${prompt_symbol}${reset} "
}

# -----------------------------------------------------------------------------

# PROMPT ORDER

prompt_modules=(
  "dir_module"
  "git_branch_module"
  "git_dirty_module"
  "exit_code_module"
)

# -----------------------------------------------------------------------------

# POINT OF ENTRY

compose_prompt() {
  RETVAL=$?

  PS1=""

  PS1+="${bold}"

  for MODULE in "${!prompt_modules[@]}"; do
    ${prompt_modules[$MODULE]}
  done
}

PROMPT_COMMAND="compose_prompt"
