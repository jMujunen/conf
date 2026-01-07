#!/bin/bash

printhelp() {
    echo -ne " \033[31m\033[0m\033[1;41m $1 \033[0m"
}

# Start from Unicode code point E0B0


start=57008

if [[ $# -lt 1 ]]; then
    end=5000
elif [[ $# -eq 1 ]]; then
    end=$1
else
    start=$1
    end=$2
fi

for ((i = $start; i < start + $end; i++)); do
    hex="$(printf '%x' $i)"
    # Convert decimal to hexadecimal, then print the character
    echo -ne "\033[1m $hex \u$hex"
done
