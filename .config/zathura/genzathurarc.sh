#!/bin/sh

# Generates zathura configuration file

DEST_DIR="${HOME}/.config/zathura"
DEST_FILE="${HOME}/.config/zathura/zathurarc"

if [ ! -d "${DEST_DIR}" ]; then
	mkdir -pv "${DEST_DIR}"
fi

get_xres() {
	xrdb -query | grep "$1" | awk '{print $2}'
}

OUTPUT="$(cat << CONF
set adjust-open "best-fit"
set pages-per-row 1
set scroll-page-aware "true"
set scroll-full-overlap 0.01
set scroll-step 100
set zoom-min 10
set guioptions ""
set font "RobotoMono 12"
set completion-bg "$(get_xres background:)"
set completion-fg "$(get_xres foreground:)"
set completion-group-bg "$(get_xres background:)"
set completion-group-fg "$(get_xres color1:)"
set completion-highlight-bg "$(get_xres foreground:)"
set completion-highlight-fg "$(get_xres background:)"
set default-bg "$(get_xres background:)"
set default-fg "$(get_xres foreground:)"
set inputbar-bg "$(get_xres background:)"
set inputbar-fg "$(get_xres color3:)"
set notification-bg "$(get_xres background:)"
set notification-fg "$(get_xres foreground:)"
set notification-error-bg "$(get_xres color1:)"
set notification-error-fg "$(get_xres foreground:)"
set notification-warning-bg "$(get_xres color1:)"
set notification-warning-fg "$(get_xres foreground:)"
set statusbar-bg "$(get_xres background:)"
set statusbar-fg "$(get_xres foreground:)"
set index-bg "$(get_xres background:)"
set index-fg "$(get_xres foreground:)"
set index-active-bg "$(get_xres foreground:)"
set index-active-fg "$(get_xres background:)"
set render-loading-bg "$(get_xres background:)"
set render-loading-fg "$(get_xres foreground:)"

set smooth-scroll true
set window-title-home-tilde true
set statusbar-basename true
set selection-clipboard clipboard
CONF
)"

printf '%s' "$OUTPUT" > "${DEST_FILE}"
