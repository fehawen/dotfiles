#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 133

xsetroot -solid "#32323E"

setxkbmap se

exec i3
