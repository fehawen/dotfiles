#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

~/.local/bin/luv

setxkbmap -layout se

exec sowm
