#!/usr/bin/env bash

# shellcheck disable=SC1090
[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

# Start X
if systemctl -q is-active graphical.target && \
    [[ ! $DISPLAY && $XDG_VTNR -eq 1 && "$(tty)" = "/dev/tty1" ]] && \
    ! pgrep -x sowm >/dev/null; then
    exec startx
fi
