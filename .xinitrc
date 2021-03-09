#!/bin/sh

#
# .xinitrc
#

xset b off
xset m 1/1
xset +fp ~/.fonts
xset r rate 200 40
xrdb ~/.Xresources
xrandr --dpi 192

# shellcheck disable=SC1090
[ -f ~/.cache/rpg/colors.sh ] && . ~/.cache/rpg/colors.sh

xsetroot -solid "${color8:=#777777}"
setxkbmap -layout se

exec sowm
