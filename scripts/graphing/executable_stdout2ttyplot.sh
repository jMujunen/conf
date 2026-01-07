#!/bin/bash

# Plot sys temp
{ while true; do
    sensors | grep -A 3 iwlwifi_1-virtual-0 | sed -n -E '/[0-9]{2}/p' | sed -E 's/.*([0-9]{2}).*/\1/g'
    sleep 0.2
done; } | ttyplot -c . -m 60 -M 25 -u °C

# Plot GPU Wattage
{ while true; do
    nvidia-smi --query-gpu=power.draw --format=csv,noheader | sed -E "s/([0-9]+).*/\1/g"
    sleep 0.2
done; } | ttyplot -c . -m 200 -M 5 -u W

# Gpu Power
{ while true; do
    nvidia-smi --query-gpu=power.draw --format=csv,noheader | sed -E "s/([0-9]+).*/\1/g"
    sleep 0.2
done; } | ttyplot -c . -m 200 -M 5 -u W
# Mem
sar -r 1 \
    | perl -lane 'BEGIN{$|=1} print "@F[5]"' \
    | ttyplot -s 100 -t "memory used %" -u "%"
# Plot fan1
{ while true; do
    sensors | grep fan1: | sed -E 's/.*([0-9]{3,4}).*/\1/g' | tee -a /tmp/fan.log
    sleep 0.2
done; } | ttyplot -c . -m 1000 -M 25 -u RPM

# Plot cpu voltsa
{ while true; do
    echo -e "\033[1;32m $(sensors | grep VIN3 | awk '{print $2 / 1000}' | tee -a /tmp/cpuvolts.log) \033[0m"
    #echo -e "\033 $(sensors | grep VIN3 | awk '{print $2 / 1000}'| tee -a /tmp/fan.log)
    sleep 0.2
done; } | ttyplot -c . -m 1.5 -M 0.5 -u V

# Plot cpu volts
{ while true; do
    echo -e "\033[1;32m $(sensors | grep VIN7 | awk '{print $2 / 1000}' | tee -a /tmp/cpuvolts1.log) \033[0m"
    #echo -e "\033 $(sensors | grep VIN3 | awk '{print $2 / 1000}'| tee -a /tmp/fan.log)
    sleep 0.2
done; } | ttyplot -c . -m 1.5 -M 0.5 -u V

# TODO: Make better
# - [ ] The script you provided is quite comprehensive and covers a wide range of topics including system monitoring, data processing with sensors command, GPU power usage monitoring with nvidia-smi command, and terminal plotting with ttyplot command. However, there are several improvements that could be made to improve readability, maintainability, or both:

# - [ ]  Variable Naming: The variable names in the script are quite cryptic. It would be helpful if they were more descriptive. For example, instead of $2 / 1000, you might name it like this: cpu_voltage_millivolts or something similar.

# - [ ]  Comments: The script lacks comments explaining what each part does. Adding comments to the code can make it easier for others (and future you) to understand what's going on.

# - [ ]  Consistent Indentation and Spacing: Your indentation is not consistent, which makes it hard to read. Make sure that your script has a uniform formatting.

# - [ ]  Error Handling: The script does not handle errors or exceptions. Adding error handling can make the script more robust and easier to debug. For example, if nvidia-smi command fails for some reason, it could be helpful to catch that failure and print an appropriate message.

# - [ ]  Code Duplication: The last two sections of code are almost identical except for the input source (VIN3 vs VIN7). Consider creating a function or method to handle this duplication.

# - [ ]  Use of tee command: The use of tee -a /tmp/cpuvolts.log is repeated in multiple places, which could be abstracted into its own function for better maintainability and readability.

# - [ ]  Bash Script Best Practices: Use the shebang (#!/bin/bash) to specify your script should be run with bash. This helps ensure that if someone tries to run it with a different shell, they'll get an error message telling them to use bash.

# - [ ]  Use of {} and (): The usage of {} is not necessary for running commands sequentially in the script. You can replace these with simple command sequences (do...done). Similarly, () could be used for creating subshells but it's not needed here.

# - [ ]  Avoid using sleep: The use of sleep 0.2; makes your script run at a very high speed and might cause performance issues. If the data is required in real-time, consider using tools like watch or inotifywait to monitor file changes instead of sleeping between each iteration.
