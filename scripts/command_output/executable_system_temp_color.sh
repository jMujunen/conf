#!/bin/bash

output=$(sensors | grep -oP "(?:Sensor 2:) \s+\+\d+\.\d" | awk -F+ '{print $2}')

if [[ $output -gt 45 ]]; then
    echo -e "\e[33m$output\e[0m"
elif [[ $output -gt 55 ]]; then
    echo -e "\e[31m$output\e[0m"
else
    echo -e "\e[38;2;99;176;105m$output\e[0m"
fi
