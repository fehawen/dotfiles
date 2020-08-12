#!/usr/bin/env bash

symlink_tilde_files() {
    tildes=(
        ".asoundrc"
        ".dashrc"
        ".hushlogin"
        ".profile"
        ".vimrc"
        ".Xresources"
    )

    cd tilde || exit 1

    for file in "${tildes[@]}"; do
        ln -sfv "$PWD/$file" "$HOME/$file"
    done

    cd "$(dirs -l -0)" && dirs -c
}

symlink_files() {
    exit_on_fail pushd "$PWD/$1"

    for FILE in *; do
        if [ -f "$FILE" ]; then
            printf 'Symlinking %s -> %s\n' "${HOME/#$HOME/"~"}/$1/$FILE" "${PWD/#$HOME/"~"}/$FILE"
            exit_on_fail ln -sf "$PWD/$FILE" "$HOME/$1/$FILE"
        fi
    done

    cd "$(dirs -l -0)" && dirs -c
}

setup_dotfiles() {
    printf 'Setting up dotfiles...\n'

    folders=(
        ".config/fontconfig"
        ".config/nvim"
        ".newsboat"
        "tilde"
    )

    shopt -s dotglob

    for folder in "${folders[@]}"; do
        if [[ "$folder" == "tilde" ]]; then
            symlink_tilde_files
        else
            if [[ ! -d "$HOME/$folder" ]]; then
              printf 'Directory "%s" does not exist.' "$folder"
              printf 'Creating dir "%s"' "$folder"
              exit_on_fail mkdir -p "$HOME/$folder"
            fi

            symlink_files "$folder"
        fi
    done

    shopt -u dotglob

    printf 'Done.\n'
}

setup_dotfiles
