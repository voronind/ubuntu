#!/bin/bash

repo="$(dirname "$0")/files"

backup() {
    local path="$1"

    if [[ $path == ~/* ]]; then
        local repo_path="$repo/home${path#"$HOME"}"
    else
        local repo_path="$repo$path"
    fi

    medium_dir="$(dirname $repo_path)"
    test -d "$medium_dir" || mkdir -p "$medium_dir"

    cp "$path" "$repo_path"

    git add "$repo_path"
}

main() {
    backup /etc/fstab
    backup /etc/sysctl.conf
    backup ~/.bashrc
    backup ~/.cookiecutterrc
    backup ~/.gitconfig
    backup ~/.luarocks/config.lua
    backup ~/.pypirc
    backup ~/.zbstudio/user.lua
}

if [ -z "$1" ]; then
    main
else
    backup "$1"
fi
