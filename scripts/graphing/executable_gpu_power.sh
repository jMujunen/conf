#!/bin/bash
{ while true; do
    nvidia-smi --query-gpu=power.draw --format=csv,noheader | sed -E "s/([0-9]+).*/\1/g"
    sleep 0.2
done; } | ttyplot -c  ░ -m 330 -C '173' -M 5 -u W -s 10000
