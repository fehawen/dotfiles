#!/bin/bash

screen_width=$(echo $(xrandr | grep \* | awk '{print $1}' | cut -dx -f1))
bars=4

bar_size=$(echo $((${screen_width} / ${bars})))

echo ${bar_size}
