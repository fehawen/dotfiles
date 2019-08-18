#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 133

xsetroot -solid "#1c262a"

setxkbmap se

exec i3
