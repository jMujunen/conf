#!/bin/bash
if ! nvidia-smi -pl 350.00 >/dev/null; then
    echo -e "\033[31mRoot privilages required\033[0m"
    exit 1
else
    nvidia-smi --lock-gpu-clocks=220,2195 --mode=1 >/dev/null
    nvidia-smi --lock-memory-clocks=440,10501 >/dev/null
fi

nvidia-settings -a GPUGraphicsClockOffsetAllPerformanceLevels=100 \
-a GPUMemoryTransferRateOffsetAllPerformanceLevels=1000 --display DP-2


echo "New OC:"
echo "2195MHz Core"
echo "10001MHz Memory"
echo "Power Limit: 350w"
