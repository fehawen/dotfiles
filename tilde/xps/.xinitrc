#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

feh --bg-fill ~/.wallpapers/wall.jpg

setxkbmap -layout se

dunst -config "$HOME/.config/dunst/dunstrc" &

exec sowm
