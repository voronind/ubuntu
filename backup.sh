#!/bin/bash

PROJECT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

backup_dir() {
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
    backup_dir "$HOME" home
    backup_dir / root
fi
