#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#xrandr --dpi 133
#xrandr --dpi 220

xsetroot -solid "#182226"

setxkbmap se

exec i3
