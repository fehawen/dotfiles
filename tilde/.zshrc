# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/fehawen/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
	user
	dir
	git
	docker
	kubecontext
	exec_time
	line_sep
	exit_code
	char
)

SPACESHIP_CHAR_SYMBOL="→ "
SPACESHIP_GIT_STATUS_AHEAD="↑"
SPACESHIP_GIT_STATUS_BEHIND="↓"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases
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
alias glog='git log --oneline --decorate --color --graph'
alias gfetch='git fetch'
alias gpull='git pull'
alias gbranch='git branch --list'
alias gbranchr='git branch -r'
alias gbranchv='git branch -v'
alias gcheck='git checkout'
alias gcheckb='git checkout -b'
alias gstash='git stash'
alias gstasha='git stash apply'
alias gstashl='git stash list'
alias gstashd='git stash drop'
alias code='open -a "Visual Studio Code"'
alias gh='cd ~/Github/'
alias repos='cd ~/Github/'
alias dot='cd ~/Dotfiles/'
alias projects='cd ~/projects/'
alias bashrc='source ~/.bashrc'
alias mongorun='mongod --dbpath ~/paths/mongodb-osx-x86_64-4.0.3/data'
alias start-chunkwm='brew services start koekeishiya/formulae/chunkwm'
alias restart-chunkwm='brew services restart koekeishiya/formulae/chunkwm'
alias stop-chunkwm='brew services stop koekeishiya/formulae/chunkwm'
alias start-skhd='brew services start koekeishiya/formulae/skhd'
alias restart-skhd='brew services restart koekeishiya/formulae/skhd'
alias stop-skhd='brew services stop koekeishiya/formulae/skhd'
alias todoread='cat ~/Github/todo/README.md'
alias todoedit='nvim ~/Github/todo/README.md'
alias todopush=push_todos
alias todopull=pull_todos
alias gconf=git_config
alias hunt=find_exact_match

push_todos() {
	pushd $HOME/Github/todo/ && \
	git add . && \
	git commit -m 'Bump.' && \
	git push && \
	popd
}

pull_todos() {
	pushd $HOME/Github/todo/ && \
	git pull && \
	popd
}

git_config() {
	command git config user.name $1 && git config user.email $2
}

# Search function, called on with alias 'hunt' -- e.g. hunt 'const' to find all occurences of 'const' in dir w/ subdirs
find_exact_match() {
	command grep --exclude-dir=node_modules -wroni "$1" . | sort -u | grep -iv "^$1" | sed '/^$/d' | grep -i --color=always "$1"
}

# Path
typeset -U path
path=(~/.npm-global/bin $path)
