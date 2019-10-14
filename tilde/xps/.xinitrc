#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#xrandr --dpi 133
#xrandr --dpi 220

xsetroot -solid "#0D202F"

setxkbmap se

exec i3
