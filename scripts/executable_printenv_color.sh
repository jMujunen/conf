#!/bin/bash

# printenv_color.sh - Adds color to printenv output
# Usage: ./printenv_color.sh

variable=$(printenv | grep -o -E "^[a-zA-Z0-9]+[^=]*")

for var in $variable; do
    value=$(printenv | grep -o -P "^$var=.*" | sed -E "s/$var=(.*)/\1/g")
    printf "\033[38;2;99;176;105m%-30s\033[0m = \033[38;5;208m%s\033[0m\n" "$var" "$value"
done
