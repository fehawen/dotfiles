#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 133

# xsetroot -solid "#18202A"
xsetroot -solid "#162023"

setxkbmap se

exec i3
