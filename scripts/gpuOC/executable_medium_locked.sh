#!/bin/bash
if ! nvidia-smi --lock-gpu-clocks=1500,1800 --mode=1; then
    exit 1
else
    nvidia-smi --lock-memory-clocks=5001,9501 || exit 1
fi
echo "New OC:"
echo "1500-1800MHz Core"
echo "5000-9500MHz Memory"
