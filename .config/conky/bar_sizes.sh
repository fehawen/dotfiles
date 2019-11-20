#!/bin/bash

# This works, but does not take into consideration possible xrandr scaling,
# it only uses the monitor's highest listed internal resolution
# screen_width=$(echo $(xrandr | grep \* | awk '{print $1}' | cut -dx -f1))

# This works better as it uses the monitor's actual current resolution
# If the --listmonitors flag prints out plural, try --listactivemonitors flag instead
screen_width=$(echo $(xrandr --listmonitors | grep \+ | awk '{print $3}' | cut -d/ -f1))
bars=4

bar_size=$(echo $((${screen_width} / ${bars})))

echo ${bar_size}
