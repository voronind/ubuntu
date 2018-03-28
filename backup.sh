#!/bin/bash

repo="$(dirname "$0")/files"

backup() {
    local path="$1"

    if [[ $path == home/* ]]; then
        local local_path="$HOME${path#home}"
    else
        local local_path="/$path"
    fi

    cp "$local_path" "$repo/$path"
}

backup etc/fstab
backup etc/sysctl.conf
backup home/.bashrc
backup home/.cookiecutterrc
backup home/.gitconfig
backup home/.pypirc
