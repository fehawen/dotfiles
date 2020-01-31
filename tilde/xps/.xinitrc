#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

feh --bg-fill ~/.wallpapers/wall.jpg

setxkbmap -layout se

exec sowm
exec ~/.config/conky/launch.sh
