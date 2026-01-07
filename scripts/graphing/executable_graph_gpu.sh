#!/bin/bash
# graph_gpu.sh - Graphs the main GPU's sensor data using ttyplot

# Print help message
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "Usage: ./graph_gpu.sh OPTION PLOT_CHAR="
    echo "OPTIONS: "
    echo "  -m Memory clock"
    echo "  -c Core clock"
    echo "  -t: Temperature in Celsius"
    echo "  -l: Core load in percent"
    echo "  -u: Core utilization in percent"
    echo "  -w: Power draw in watts"
    exit 0
fi

# Check if required arguments are provided
if [ "$#" -gt 2 ]; then
    echo "Error: Invalid number of arguments. Use --help for usage information."
    exit 1
fi

# Default plot character
PLOT_CHAR="░"
if [ "$2" ]; then
    PLOT_CHAR=$2
    echo -e "$PLOT_CHAR"
fi

# Graph specified value
if [ "$1" == "-t" ]; then
    nvidia-smi --loop-ms=200 --query-gpu=timestamp,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed --format=csv \
        | sed -u 's/timestamp//g; s/^.*fan.speed [%]//g; s/^.*W,//g; s/,.*//g' \
        | ttyplot -c $PLOT_CHAR -s 100 -t "GPU TEMP -u Celsius" -u C

    exit 0
fi

# Graph temp
if [ "$1" == "-m" ]; then
    nvidia-smi --loop-ms=200 --query-gpu=timestamp,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed --format=csv \
        | sed -u 's/timestamp//g; s/^.*fan.speed [%]//g; s/^.*W,//g; s/,.*//g' \
        | ttyplot -c $PLOT_CHAR -s 100 -t "GPU Memory Clock" -u MHz
    exit 0
fi

if [ "$1" == "-c" ]; then
    nvidia-smi --loop-ms=200 --query-gpu=timestamp,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed --format=csv \
        | sed -u 's/timestamp//g; s/^.*fan.speed [%]//g; s/^.*W,//g; s/,.*//g' \
        | ttyplot -c $PLOT_CHAR -s 100 -t "GPU Core Clock" -u MHz
    exit 0
fi

if [ "$1" == "-l" ]; then
    nvidia-smi --loop-ms=200 --query-gpu=timestamp,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed --format=csv \
        | sed -u 's/timestamp//g; s/^.*fan.speed [%]//g; s/^.*W,//g; s/,.*//g' \
        | ttyplot -c $PLOT_CHAR -s 100 -t "GPU Core Load" -u %
    exit 0
fi

if [ "$1" == "-u" ]; then
    nvidia-smi --loop-ms=200 --query-gpu=timestamp,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed --format=csv \
        | sed -u 's/timestamp//g; s/^.*fan.speed [%]//g; s/^.*W,//g; s/,.*//g' \
        | ttyplot -c $PLOT_CHAR -s 100 -t "GPU Core Utilization" -u %
    exit 0
fi

if [ "$1" == "-w" ]; then
    nvidia-smi --loop-ms=200 --query-gpu=timestamp,utilization.gpu,power.draw,temperature.gpu,clocks.current.graphics,clocks.current.memory,fan.speed --format=csv \
        | sed -u 's/timestamp//g; s/^.*fan.speed [%]//g; s/^.*W,//g; s/,.*//g' \
        | ttyplot -c $PLOT_CHAR -s 100 -t "GPU Power Draw" -u W
    exit 0
fi
