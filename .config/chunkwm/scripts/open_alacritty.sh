#!/bin/bash

# Detects if Alacritty is running
if ! pgrep -f "Alacritty" > /dev/null; then
    open -na "/Applications/Alacritty.app"
else
    # Create a new window
    if ! osascript -e 'tell application "Alacritty" to create window with default profile' > /dev/null; then
        # Get pids for any app with "Alacritty" and kill
        for i in $(pgrep -f "Alacritty"); do kill -15 "$i"; done
        open  -na "/Applications/Alacritty.app"
    fi
fi