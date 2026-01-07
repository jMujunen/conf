#!/bin/bash

# Define the filename with date and time
FILENAME="$HOME/Pictures/Screenshots/Area_$(date +%F_%H-%M-%S).png"

# Take a screenshot of a selected area
import "$FILENAME" && notify-send -i camera-photo-symbolic -t 3000 "Screenshot Taken" "Screenshot of selected area saved as $FILENAME" || notify-send -i camera-photo-symbolic -t 3000 "Area screenshot failed!" "Error occured when taking a screenshot"
