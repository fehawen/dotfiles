#!/usr/bin/env bash

# Terminate already running conky instances
killall -q conky

# Wait until the processes have been shut down
while pgrep -u $UID -x conky >/dev/null; do sleep 1; done

# Launch conky
conky -c ~/.config/conky/conky_left.lua &
conky -c ~/.config/conky/conky_right.lua &
