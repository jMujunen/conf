#!/bin/bash

# find_files_in_dir_tree.sh - Find jpg, png, svg, ico files in a directory tree
# to consolidate to a folder
# -------------------------
# ^ ./find_files_in_dir_tree.sh PATH

dir_path="$(pwd)/icons"
echo "$dir_path"
printhelp() {
    echo "Usage:"
    echo -e "\t ./find_files_in_dir_tree.sh PATH"
    echo -e "\t\tDefault: $(pwd)"
}

# Make dir and supress output (in the many cases where it already exsists)
mkdir "$dir_path" > /dev/null 2>&1

# Check for optional `path` paramter
if not [ -z $1 ]; then
    dir_path="$1"
fi
# dir_path == "$(pwd)/icons" if not $1 else dir_path="$1"

find . -type f -name "*.jpg" -o -name "*.png" -o -name "*.svg" -o -name "*.ico" -exec sh -c \
    'mv -v {} "$dir_path"' \;
