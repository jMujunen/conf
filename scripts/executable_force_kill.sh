#!/bin/bash

# force_kill.sh - force kill known problem processes

if [[ "$#" -eq 1 ]]; then
    zenity --question --text="Kill all?" || exit
fi

# Wine
kill 997 1021 > /dev/null 2>&1
wineserver -k 15 && echo "Killed wineserver" || echo "wineserver not running"
# Ollama
killall -9 ollama > /dev/null 2>&1
killall -9 ollama_llama_server > /dev/null 2>&1 && echo "Killed Ollama" || echo "Ollama not running"

# Steam
killall -9 steamwebhelper > /dev/null 2>&1 && echo "Killed Steam" || echo "Steam not running"

# Osrs
proc_ids=$(pgrep agex)

for proc in $proc_ids; do
    kill -9 "$proc" && echo -e "\033[32mKilled PID $proc\033[0m" || echo -e "\033[31mError killing PID $proc\033[0m"
done

ps x | grep -iP "Jagex" | awk '{print $1}' | xargs -P20 kill -9 > /dev/null 2>&1 && echo "Killed Jagex" || echo "Jagex not running"
