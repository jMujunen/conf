#!/bin/bash

echo $(ping -c 1 1.1.1.1 | grep -Po "(?:time=)(\d+\.\d\s|\d{3})\s?ms" | sed -E 's/time=//g')
