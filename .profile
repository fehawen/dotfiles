#
# .profile
#

# shellcheck disable=1090
[ -f ~/bin/ttt ] && . ~/bin/ttt

export PATH=~/bin:~/.local/bin:~/.yarn/bin:~/.npm-global/bin:~/.dotnet/tools:$PATH
export ENV=~/.shrc
