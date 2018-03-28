#!/bin/bash

repo="$(dirname "$0")/files"

backup() {
    local path="$1"

    if [[ $path == ~/* ]]; then
        local repo_path="$repo/home${path#"$HOME"}"
    else
        local repo_path="$repo$path"
    fi

    cp "$path" "$repo_path"
}

main() {
    backup /etc/fstab
    backup /etc/sysctl.conf
    backup ~/.bashrc
    backup ~/.cookiecutterrc
    backup ~/.gitconfig
    backup ~/.pypirc
}

if [ -z "$1" ]; then
    main
else
    backup "$1"
fi
