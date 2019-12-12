#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

feh --bg-fill ~/.wallpapers/stairway.jpg

setxkbmap -layout se

exec i3
