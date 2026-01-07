#!/bin/bash

add_commas() {
    echo "$1" | awk '{ printf "%\047d\n", $1 }'
}

# Example usage
result=$(add_commas "$1")
echo "$result" # Output: 1,000
