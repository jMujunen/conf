#!/bin/bash
while true; do
	output=$(ping -c 1 10.0.0.1 \
		| sed -u 's/^.*time=//g; s/ ms//g; s/^PING.*//g; s/^---.*//g; s/^.*packets.*//g; s/^rtt.*//g' \
		| grep -oP "\d+(\.\d+)?" \
		| xargs echo)
# Round to 1 decimal places
rounded=$(printf "%.1f" "$output")
echo "$rounded" >> /tmp/.ping
sleep 0.2
done
