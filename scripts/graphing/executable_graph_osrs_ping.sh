#!/bin/bash

# graph_osrs_ping.sh - Graphs ping results using ttyplot - Helps get better ticks

ping -i 0.242551671115 oldschool78.runescape.com \
    | sed -u 's/^.*time=//g; s/ ms//g' \
    | ttyplot -c $(echo -ne " \u$(printf '%x' 9617) ") -t "hi" -u ms
