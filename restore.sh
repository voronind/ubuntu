#!/bin/bash

merge="$HOME/pycharm/bin/pycharm.sh merge"
repo=https://github.com/dimka665/ubuntu/raw/master/files
tmp=/tmp/wget-ubuntu

get() {
    local action="$1"
    local path="$2"
    local mode="$3"

    if [[ $path == home/* ]]; then
        local local_path="$HOME${path#home}"
    else
        local local_path="/$path"
        local merge="sudo $merge"
    fi

    if [[ $action == "merge" ]]; then
        wget $repo/$path -O $tmp
        $merge $local_path $tmp $local_path
        rm $tmp
    else
        wget $repo/$path -O $local_path
    fi

    if [[ $mode == "x" ]]; then
        chmod +x $local_path
    fi
}

get merge etc/fstab
get merge etc/sysctl.conf
get merge home/.bashrc
get merge home/.cookiecutterrc
get merge home/.gitconfig
get merge home/.pypirc

get copy home/.local/read-editor.sh  x
get copy home/.local/share/nautilus/scripts/Rename  x

touch ~/Templates/Text.txt
