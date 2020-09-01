#!/bin/sh

package_list() {
    printf '%s ' \
        "xorg-server" \
        "xorg-xinit" \
        "xorg-xrandr" \
        "xorg-xsetroot" \
        "xorg-xbacklight" \
        "xf86-video-intel" \
        "xf86-input-libinput" \
        "gnu-free-fonts" \
        "mesa" \
        "man-db" \
        "man-pages" \
        "texinfo" \
        "imagemagick" \
        "alsa-utils" \
        "alsa-lib" \
        "pulseaudio" \
        "pamixer" \
        "dmenu" \
        "w3m" \
        "firefox" \
        "chromium" \
        "zip" \
        "unzip" \
        "p7zip" \
        "npm" \
        "docker" \
        "docker-compose" \
        "openssh" \
        "zathura" \
        "poppler" \
        "zathura-pdf-poppler" \
        "python-pip" \
        "python-pillow" \
        "jq" \
        "noto-fonts-emoji" \
        "gnu-netcat" \
        "tree"
}

install_packages() {
    printf 'Installing packages for Arch Linux...\n'

    sudo pacman -Syu "$(package_list)"

    printf "Done.\n"
}

install_packages
