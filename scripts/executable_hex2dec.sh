#!/bin/bash
# ./hex2dec <value> - Returns the decimal representaition of a hexadecimal
hex_code=$1

if [ -z "$hex_code" ]; then
    echo "Error: No hex code provided"
    exit 1
fi

dec_value=$(printf '%d' $(echo "0x$hex_code" | bc))

echo $dec_value
