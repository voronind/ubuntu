#!/bin/bash

merge="$HOME/pycharm/bin/pycharm.sh merge"
repo=https://github.com/dimka665/ubuntu/raw/master/files
tmp=/tmp/wget-ubuntu

get() {
    local action="$1"
    local path="$2"
    local mode="$3"

    if [[ $path == ~/* ]]; then
        local repo_path="$repo/home${path#"$HOME"}"
    else
        local repo_path="$repo$path"
        local merge="sudo $merge"
    fi

    if [[ $action == "merge" ]]; then
        wget $repo_path -O $tmp
        $merge $path $tmp $path
        rm $tmp
    elif [[ $action == "copy" ]]; then
        wget $repo_path -O $path
    else
        echo "You must specify 'merge' or 'copy' command."
    fi

    if [[ $mode == "x" ]]; then
        chmod +x $path
    fi
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

if [ -z "$1" ]; then
    main
else
    get $1 "$2" $3
fi
