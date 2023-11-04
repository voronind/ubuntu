#!/bin/bash

copy_file() {
    local source_path="$1"

    if [[ "$source_path" =~ home/(.+) ]]; then
        local dest_path="$HOME/${BASH_REMATCH[1]}"
    elif [[ "$source_path" =~ root/(.+) ]]; then
        local dest_path="/${BASH_REMATCH[1]}"
    fi

    cp $source_path $dest_path
}

main() {
    get merge /etc/fstab
    get merge /etc/sysctl.conf
    get merge ~/.bashrc
    get merge ~/.cookiecutterrc
    get merge ~/.gitconfig
    get merge ~/.luarocks/config.lua
    get merge ~/.pypirc

    get copy ~/.local/bin/read-editor.sh  x
    get copy ~/.local/share/nautilus/scripts/Rename  x

    touch ~/Templates/Text.txt
}

copy_file "$1"
