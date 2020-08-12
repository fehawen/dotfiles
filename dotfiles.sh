#!/bin/sh

#
# dotfiles.sh
#

sym() {
    for file in .*; do
        case $file in
            .) ;;
            ..) ;;
            .git) ;;
            .gitignore) ;;
            *) [ -f "$file" ] && ln -sfv "$PWD/$file" "$HOME/$file" ;;
        esac
    done

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
