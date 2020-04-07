#!/usr/bin/env bash

confirm() {
    read -r -p "Proceed with $1 setup for $2? [y/N] " answer
    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        printf "Setup declined...\n"
        printf "Now exiting.\n"
        exit
    else
        ./"$1".sh
    fi
}

COLUMNS=12

PS3="Please select an option: "

declare -a options=(
    "Arch Linux - Dotfiles"
    "Arch Linux - Packages"
    "Arch Linux - Config"
    "Arch Linux - Fonts"
    "Quit"
)

select opt in "${options[@]}"
do
    case $opt in
        "Arch Linux - Dotfiles")
            confirm "dotfiles" "Arch Linux"
            break
            ;;
        "Arch Linux - Packages")
            confirm "packages" "Arch Linux"
            break
            ;;
        "Arch Linux - Config")
            confirm "config" "Arch Linux"
            break
            ;;
        "Arch Linux - Fonts")
            confirm "fonts" "Arch Linux"
            break
            ;;
        "Quit")
            echo "Quitting..."
            break
            ;;
        *) printf 'Invalid option: %s' "$REPLY";;
    esac
done
