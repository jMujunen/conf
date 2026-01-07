#!/bin/bash

# termsize.sh - Display terminal window size dynamically

redraw() {
    clear
    w=$(tput cols)
    h=$(tput lines)
    printf "%*s%*s\n" 2 w 10 h
    printf "%-*d%-*d\n" 10 "$w" 10 "$h"
}

trap redraw WINCH
trap exit SIGINT

redraw
while true; do
    :
done
