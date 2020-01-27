#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xsetroot -solid "#001B24"

setxkbmap -layout se

exec i3
