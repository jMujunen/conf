#!/bin/bash

# Define the filename with date and time
FILENAME="$HOME/Pictures/Screenshots/Screenshot_$(date +%F_%H-%M-%S).png"

# Take a screenshot with scrot and save it to the defined filename
scrot "$FILENAME"
kitten icat "$FILENAME"

# Notify the user where the screenshot has been saved
notify-send -i camera-photo-symbolic -t 3000 "Screenshot Taken" "Screenshot saved as $FILENAME"
