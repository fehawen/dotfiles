#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

xrandr --dpi 55

~/.local/bin/luv

setxkbmap -layout se

exec sowm
