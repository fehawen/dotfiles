#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 133

xsetroot -solid "#282833"

setxkbmap se

exec i3
