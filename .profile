#
# .profile
#

export PATH=~/bin:~/.yarn/bin:~/.npm-global/bin:~/.dotnet/tools:$PATH
export ENV=~/.shrc

[ "$DISPLAY" ] || {
    export DISPLAY=:0
    read -r _ && stx
}
