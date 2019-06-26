#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources & xrandr --dpi 180

setxkbmap se

exec i3
