#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xsetroot -solid "#000000"

setxkbmap -layout se

exec i3
