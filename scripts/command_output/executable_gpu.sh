#!/bin/bash

line=$(tail -1 /tmp/hwinfo.csv | awk '{print $3" °C,",$7" W,",$8" %,",$10" V,",6" %,",$4" MHz"}' | sed -E 's/([0-9]),/\1/g')

echo $line
