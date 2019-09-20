#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 60

xsetroot -solid "#182226"

setxkbmap se

exec i3
