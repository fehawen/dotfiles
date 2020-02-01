#!/usr/bin/env bash

# This works, but does not take into consideration possible xrandr scaling,
# it only uses the monitor's highest listed internal resolution
#
# screen_width=$(echo $(xrandr | grep \* | awk '{print $1}' | cut -dx -f1))
#

# This works better as it uses the monitor's actual current resolution
# If the --listmonitors flag prints out plural, try --listactivemonitors flag instead
declare screen_width="$(xrandr --listmonitors | grep \+ | awk '{print $3}' | cut -d/ -f1)"
declare bars=4

declare bar_size="$((${screen_width} / ${bars}))"

echo ${bar_size}
