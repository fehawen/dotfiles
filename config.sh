#!/usr/bin/env bash

configure_touchpad() {
    read -r -p "Configure touchpad? [y/N] " answer
    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        printf 'Skipping touchpad configuration...\n'
    else
        printf 'Configuring touchpad...\n'
        printf 'Writing content to "/usr/share/X11/xorg.conf.d/40-libinput.conf"...'

sudo tee -a /usr/share/X11/xorg.conf.d/40-libinput.conf >> /dev/null << EOT

Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Option "Tapping" "true"
        Option "TappingDrag" "false"
        Option "NaturalScrolling" "true"
        Option "AccelProfile" "linear"
        Option "AccelSpeed" "0.25"
        Option "DisableWhileTyping" "false"
        Driver "libinput"
EndSection

EOT

        printf "Done.\n"
    fi
}

enable_docker() {
    read -r -p "Start and enable Docker? [y/N] " answer
    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        printf "\nSkipping Docker systemctl setup...\n"
    else
        printf "\nStarting Docker through systemctl..."
        systemctl start docker

        printf "\nStarting Docker through systemctl..."
        systemctl enable docker

        printf "DONE.\n"
    fi
}

configure_docker() {
    read -r -p "Manage Docker as a non-root user? [y/N] " answer
    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        printf 'Skipping Docker non-root configuration...\n'
    else
        printf "\nAdding 'docker' group..."
        sudo groupadd docker

        printf '\nAdding user %s to docker group...' "$USER"
        sudo usermod -aG docker "$USER"

        printf "DONE.\n"
    fi
}

configure_npm() {
    read -r -p "Manage NPM as a non-root user? [y/N] " answer
    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        printf "\nSkipping NPM non-root configuration...\n"
    else
        local npm_dir="$HOME/.npm-global"

        if [[ ! -d "$npm_dir" ]]; then
            printf '\nCreating dir %s...\n' "$npm_dir"
            mkdir -p "$npm_dir"
        else
            printf '\nDirectory %s exists...\n' "$npm_dir"
        fi

        printf '\nAdding to %s npm config...' "$npm_dir"
        npm config set prefix "$HOME/.npm-global"
        printf "DONE.\n"
    fi
}

configure_neovim() {
    read -r -p "Install dependencies for NeoVim and plugins? [y/N] " answer
    if [[ "$answer" != y ]] && [[ "$answer" != Y ]]; then
        printf "\nSkipping NeoVim configuration...\n"
    else
        printf "\nEnabling Python3 with 'pip3 install --user pynvim' command..."
        pip3 install --user pynvim

        printf "\nInstalling neovim NPM package..."
        npm install -g neovim

        printf "DONE.\n"
    fi
}

configure_touchpad
enable_docker
configure_docker
configure_npm
configure_neovim

printf "Configuration completed.\n"
