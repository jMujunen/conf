#!/bin/bash
if ! nvidia-smi -pl 350.00 > /dev/null 2>&1; then
    exit 1
else
    nvidia-smi --lock-gpu-clocks=1980,1980 --mode=1 > /dev/null 2>&1
    nvidia-smi --lock-memory-clocks=9501,9501 > /dev/null 2>&1
fi

echo -e "\033[1;4mNew OC:\033[0m"
echo -e "\033[32m2115MHz Core"
echo "9500MHz Memory"
echo -e "Power Limit: 350w\033[0m"
