#!/bin/bash

# double_vin.sh - Plot VIN3 and VIN7 on the same ttyplot

# Plot cpu volts
{ while true; do
    vin3reading=$(sensors | grep VIN3 | awk '{print $2 * 1000}' | tee -a /tmp/vin3.log)
    vin7reading=$(sensors | grep VIN2 | awk '{print $2 * 1000}')

    if [[ $vin3reading -lt 2000 ]]; then
        out=$(calc -p "$vin3reading"/1000)
    fi
    if [[ $vin3reading -gt 2001 ]]; then
        out=$(calc -p "$vin3reading"/1000/1000)

    fi

    if [[ $vin7reading -lt 2000 ]]; then
        vin7out=$(calc -p "$vin7reading"/1000)
    fi
    if [[ $vin7reading -gt 2001 ]]; then
        vin7out=$(calc -p "$vin7reading"/1000/1000)
    fi

    # echo "VIN3: $out" > /dev/pts/2
    # echo "VIN7 $vin7out" > /dev/pts/2
    # echo "VIN7 $vin7out" > /dev/pts/2

    echo "$vin7out"
    echo "$out"
    # Plot cpu volts
    sleep 0.2
done; } | ttyplot -2 -c ⣿ -m 1.4 -M 0.2 -u V

# # Plot cpu volts
# { while true; do
#     vin7reading=$(sensors | grep VIN3 | awk '{print $2 * 1000}'| tee -a /tmp/vin7.log)
#     if [[ $vin7reading -lt 2000 ]]; then
#         vin7out=$(calc -p "$vin7reading"/1000);
#     fi;
#     if [[ $vin7reading -gt 2001 ]]; then
#         vin7out=$(calc -p "$vin7reading"/1000/1000);
#     fi;
#     echo "$vin7out";
#     sleep 0.2;
# done } | ttyplot -c . -m 2 -M 0.5 -u V
