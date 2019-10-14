#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 60

xsetroot -solid "#0D202F"

setxkbmap se

exec i3
