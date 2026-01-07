#!/bin/bash

# recover.sh - Recover each `blob` in the repository
# For each `blob` in the repository, create a newfile in the current directory
# with the same name and contents.

function recover_tree {
    local tree=$1
    local path=$2

    # Create directory if it doesn't exist
    mkdir -p "$path"

    # Loop over all entries in the tree
    while IFS= read -r line; do
        mode=$(echo "$line" | awk '{print $1}')
        type=$(echo "$line" | awk '{print $2}')
        hash=$(echo "$line" | awk '{print $3}')
        file=$(echo "$line" | awk '{print $4}')

        if [ "$type" = "tree" ]; then
            # Recursively recover tree
            recover_tree "$hash" "$path/$file"
        elif [ "$type" = "blob" ]; then
            # Recover file
            git cat-file -p "$hash" > "$path/$file"
        fi
    done < <(git ls-tree "$tree")
}

recover_tree "$1" .
