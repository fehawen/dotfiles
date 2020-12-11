#!/bin/sh

#
# dotfiles.sh
#

sym() {
    for file in .*; do
        case $file in
            .) ;;
            ..) ;;
            *) [ -f "$file" ] && ln -sfv "$PWD/$file" "$HOME/$file" ;;
        esac
    done

    [ -d "$HOME/.mpd/playlists" ] || mkdir -p "$HOME/.mpd/playlists"

    [ -d "$HOME/.ncmpcpp" ] || mkdir -p "$HOME/.ncmpcpp"

    printf '\nDone.\n'
}

ask() {
    printf '%s\n' "Symlink dotfiles?: Press Enter to continue or Ctrl+C to abort."
    read -r _
}

main() {
    ask
    sym
}

main
