#!/bin/bash

print_help() {
    echo "Usage: ./sparce_clone.sh <remote_url> <local_dir> [files...]" >&2
    exit 1
}
# Input validation
if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    print_help
elif [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    print_help
fi

# Setup git sparse checkout for the given remote and local directories,
# with optional files to be checked out.

remoteurl="$1" localdir="$2" && shift 2

mkdir -p "$localdir"
cd "$localdir" || print_help

git init
git remote add -f origin "$remoteurl" || print_help
echo -e "\e[36m[remote = %remoteurl]\e[0m"
git config core.sparseCheckout true

# Loops over remaining args
for i; do
    echo "$i" >> .git/info/sparse-checkout
done
# If no files were specified, check out everything
if [ "$#" -eq 0 ]; then
    echo /* >> .git/info/sparse-checkout
fi

bat --paging=always -pl ini .git/info/sparse-checkout
git pull origin master \
    && echo -e "\e[32mDone!\e[0m" \
    || echo -e "\e[31mFailed to pull from origin master.\033[0m"
