#!/bin/bash

# Prompt the user to select a window
echo "Please select a window..."
WINDOW_INFO=$(xwininfo)

# Extract the window ID and name
WIN_ID=$(echo "$WINDOW_INFO" | grep "Window id:" | awk '{print $4}')
WIN_NAME=$(echo "$WINDOW_INFO" | grep "xwininfo: Window id:" | cut -d '"' -f 2 | sed 's/[^A-Za-z0-9._-]/-/g')

# Define the filename with the window name and date and time
FILENAME="$HOME/Pictures/Screenshots/${WIN_NAME}_$(date +%F_%H-%M-%S).png"

# Take a screenshot of the selected window
import -window "$WIN_ID" "$FILENAME"

# Notify the user where the screenshot has been saved
notify-send -i camera-photo-symbolic -t 3000 "Screenshot Taken" "Screenshot of $WIN_NAME saved as $FILENAME"
