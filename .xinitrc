#!/bin/sh

#
# .xinitrc
#

# shellcheck disable=1090
[ -f ~/.cache/rpg/colors.sh ] && . ~/.cache/rpg/colors.sh

xset b off
xset m 1/1
xset +fp ~/.fonts
xset r rate 200 50
xrdb ~/.Xresources
xrandr --dpi 192
xsetroot -solid "${color8:=#777777}"
setxkbmap -layout se

exec sowm
