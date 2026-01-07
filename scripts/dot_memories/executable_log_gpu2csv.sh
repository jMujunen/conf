#!/bin/bash

# log_gpu.sh - Log GPU temperature and utilization for $x seconds

function print_help() {
    echo "Usage: ./script_name.sh SECONDS FILE_NAME"
    echo "SECONDS:   Number of seconds to log."
    echo "FILE_NAME: Name of the log file."
    echo "Log file gets saved as /Logs/<FILE_NAME>.csv"
}

if [ "$1" == "--help" ]; then
    # Display usage information
    print_help
    exit 0
fi
# Check if required arguments are provided
if [ "$#" -lt 2 ]; then
    # Display usage information
    echo "Error: Invalid number of arguments."
    print_help
    exit 1
fi

# Check if required arguments are provided
if [ "$#" -gt 2 ]; then
    # Display usage information
    echo "Error: Invalid number of arguments."
    print_help
    exit 1
fi

# output=$(nvidia-smi --query-gpu=timestamp,temperature.gpu,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed \
# --format=csv)
# echo "$output" | tee ~/Logs/$2.csv

if [ ! -s /tmp/$2.csv ]; then
    echo "datetime,temperature,usage,power,core_clock,memory_clock,fan,voltage"
fi

for ((i = 1; i <= $1; i++)); do
    printf "Time Elapsed: $SECONDS/$1 \r"
    voltage=$(nvidia-smi -q --display=Voltage | grep -o -P "Graphics.*" | awk '{ printf "%.1f\n", $3}')
    output=$(nvidia-smi --query-gpu=timestamp,temperature.gpu,utilization.gpu,power.draw,clocks.current.graphics,clocks.current.memory,fan.speed \
        --format=csv,noheader,nounits)
    echo "$output, $voltage" | sed -E 's/\//-/g' | tee -a ~/Logs/$2.csv
    sleep 1
done
