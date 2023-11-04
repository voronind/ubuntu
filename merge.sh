#!/bin/bash

merge_command="$(which pycharm-community) merge"

merge_file() {
    local source_path="$1"

    if [[ "$source_path" =~ home/(.+) ]]; then
        local dest_path="$HOME/${BASH_REMATCH[1]}"
    elif [[ "$source_path" =~ root/(.+) ]]; then
        local dest_path="/${BASH_REMATCH[1]}"
    fi

    echo $dest_path

    $merge_command $dest_path $source_path $dest_path
}

main() {
    get merge_command /etc/fstab
    get merge_command /etc/sysctl.conf
    get merge_command ~/.bashrc
    get merge_command ~/.cookiecutterrc
    get merge_command ~/.gitconfig
    get merge_command ~/.luarocks/config.lua
    get merge_command ~/.pypirc

    get copy ~/.local/bin/read-editor.sh  x
    get copy ~/.local/share/nautilus/scripts/Rename  x

    touch ~/Templates/Text.txt
}

merge_file "$1"
