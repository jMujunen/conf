#!/bin/bash

{ while true; do
    echo $(sensors | grep fan1: | sed -E 's/.*([0-9]{3,4}).*/\1/g' | tee -a /tmp/fan.log)
    sleep 0.2
done; } | ttyplot -c . -m 1000 -M 25 -u RPM
