#!/bin/bash

# rm_cached.sh - Calls `git rm --cached` on deleted files from `git status`

staged=$(git -C $(pwd) status | grep -B 10000 "not staged" | grep -Po "(?<=(deleted|modified|new file):\s{3}).*") # xargs -I{} git rm --cached {}

for file in $staged; do
    echo -e "\033[0;31m$file\033[0m"
done

read -p "Are you sure you want to unstage these files? (Y/n) " -n 1 -r REPLY
echo # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]?$|^$ ]]; then
    for file in $staged; do
        git -C $(pwd) restore --staged $file > /dev/null 2> >(while read line; do echo -e "\033[31m$line\033[0m" >&2; done)
        if [ $? -eq 0 ]; then
            echo -e "\033[32mSuccessfully unstaged $file from git cache\033[0m"
        fi
    done
else
    echo "Aborted"
fi
