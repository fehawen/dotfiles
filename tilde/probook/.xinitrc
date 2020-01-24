#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

xsetroot -solid "#001B24"

setxkbmap -layout se

exec i3
