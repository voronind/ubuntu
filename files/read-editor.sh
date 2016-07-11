#!/bin/bash

read -p 'Please enter a commit message: ' -e commit_message
echo "$commit_message" > "$1"
