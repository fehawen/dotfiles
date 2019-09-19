#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#xrandr --dpi 80

xsetroot -solid "#182226"

setxkbmap se

exec i3
