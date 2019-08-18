#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 133

xsetroot -solid "#202a2e"

setxkbmap se

exec i3
