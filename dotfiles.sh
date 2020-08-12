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

    conf="fonts.conf"
    confdir=".config/fontconfig"

    mkdir -pv "$HOME/$confdir"

    (cd "$confdir" || exit 1; ln -sfv "$PWD/$conf" "$HOME/$confdir/$conf")

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
