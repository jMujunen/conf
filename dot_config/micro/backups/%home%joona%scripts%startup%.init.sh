#!/bin/bash

killall corectrl && toastify send "Corectl killed successfully"
killall ollama && toastify send "Ollama killed successfully"

# tmp hwdata log files
killl /bin/python3 /home/joona/python/Projects/Logging/csv_output.py && toastify send "hwlog initialized successfully"



