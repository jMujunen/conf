#!/bin/bash
                                        #"VOLTAGE | TEMP | CLOCK | MAX | CLOCK"
line=$(tail -1 /tmp/hwinfo.csv | awk '{print $16" V,",$13" °C,",$14" MHz,",$15" MHz"}' | sed -E 's/([0-9]),/\1/g')

echo $line
