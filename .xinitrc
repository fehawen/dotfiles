#!/bin/sh

#
# .xinitrc
#

xset b off
xset m 1/1
xset +fp ~/.fonts
xset r rate 200 50
xrdb ~/.Xresources
xrandr --dpi 192
xsetroot -solid "#08090c"
setxkbmap -layout se

conky -c ~/.conkyrc -d &

exec i3 -c ~/.i3rc
