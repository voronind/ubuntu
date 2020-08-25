#!/bin/bash

PROJECT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")


backup-file() {
    local src_path="$(realpath "$1")"
    local dest_path

    if [[ "$src_path" == "$HOME"/* ]]; then
        dest_path="$PROJECT_DIR/home${src_path#"$HOME"}"
    else
        dest_path="$PROJECT_DIR/root$src_path"
    fi

    mkdir --parents "$(dirname "$dest_path")"
    cp "$src_path" "$dest_path"
}

backup-dir() {
    local from_dir="$1"
    local to_dir="$PROJECT_DIR/$2"

    for sub_path in $(find "$to_dir" -type f -printf '%P\n')
    do
        if [[ -f "$from_dir/$sub_path" ]]; then
            cp "$from_dir/$sub_path" "$to_dir/$sub_path"
        fi
    done
}

# Script was run (not sourced)
if [[ "$BASH_SOURCE" == "$0" ]]; then
    if [[ -z "$1" ]]; then
        backup-dir "$HOME" home
        backup-dir / root
    else
        backup-file "$1"
    fi
fi
