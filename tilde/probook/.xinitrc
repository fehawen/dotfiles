#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

xrandr --dpi 55

setxkbmap -layout se

exec sowm
