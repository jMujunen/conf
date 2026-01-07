#!/bin/bash
if ! nvidia-smi --lock-gpu-clocks=0,1600 --mode=1; then
    exit 1
else
    nvidia-smi --lock-memory-clocks=0,5001 && nvidia-smi -pl 100.00
    clear
fi

echo "New OC: "
echo "Core: 1500MHz"
echo "Memory: 5000MHz"
echo "Power Limit: 100w"
