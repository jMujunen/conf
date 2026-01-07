#!/bin/bash
# dos2unix_recursive.sh - Recursively converts all files in the current directory
# from DOS format to UNIX format

# Print help message
print_help() {
    echo "Converts all files in the provided directory from DOS to UNIX line endings."
    echo "Usage: dos2unix.sh [-h|--help] DIRECTORY"
}
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] || [[ "$#" -gt 1 ]]; then
    print_help
    exit 0
fi

if [[ $# -eq 0 ]]; then
    DIR="$(pwd)"
else
    DIR="$1"
fi
# Convert dos line endings to unix. Regex matches *.py and *.sh
find "$DIR" -type f -name "*.[pPsS][yYhH]" -print0 | xargs -0 dos2unix
