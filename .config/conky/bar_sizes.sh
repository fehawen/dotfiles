#!/bin/bash

bar_sections() {
	screen_width=$(echo $(xrandr | grep \* | awk '{print $1}' | cut -dx -f1))
	padding=16
	bars=4

	divide_bars=$(echo $((${screen_width} / ${bars})))

	bar_size=$(echo $((${divide_bars} - ${padding})))

	echo ${bar_size}
}

bar_sections
