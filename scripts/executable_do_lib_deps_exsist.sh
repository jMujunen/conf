#!/bin/bash

for line in $(ldd /usr/lib/libnvidia-glvkspirv.so.550.67 | grep -Po "\/usr/.*\.\d"); do
    if [ -e "$line" ]; then
        echo "$line" exsists
    else
        echo "$line" doesnt exsist
    fi
done
