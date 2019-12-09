#!/bin/bash

declare internal_output="$(xrandr | grep "primary" | awk '{print $1}')"
declare external_output_1="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}')"

# declare external_output_1="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}' | sed -n 1p)"
# declare external_output_2="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}' | sed -n 2p)"

if [[ -z "$external_output_1" ]]; then
	xrandr --auto
elif [[ "$external_output_1" == "$external_output_2" ]]; then
	xrandr --output $internal_output --off --output $external_output --auto
else
	xrandr --output $internal_output --off --output $external_output_1 --auto --output $external_output_2 --auto --right-of $external_output_1
fi

# if [[ -z "$external_output_1" ]]; then
# 	xrandr --auto
# elif [[ "$external_output_1" == "$external_output_2" ]]; then
# 	xrandr --output $internal_output --off --output $external_output --auto
# else
# 	xrandr --output $internal_output --off --output $external_output_1 --auto --output $external_output_2 --auto --right-of $external_output_1
# fi

i3-msg "restart"
