#!/bin/bash

echo $(sensors | grep -A 3 iwlwifi_1-virtual-0 | sed -n -E '/[0-9]{2}/p' | sed -E 's/.*([0-9]{2})/\1/g')

#output=$(sensors | grep -A 3 iwlwifi_1-virtual-0 | sed -n -E '/[0-9]{2}/p' | sed -E 's/.*([0-9]{2})/\1/g')
#echo $output
