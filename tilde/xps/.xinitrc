#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xsetroot -solid "#0D202F"

setxkbmap se

exec i3
