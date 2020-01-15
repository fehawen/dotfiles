#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# feh --bg-fill ~/.wallpapers/wall.jpg
xsetroot -solid "#4C566A"

setxkbmap -layout se

exec i3
