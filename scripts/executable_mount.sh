#!/bin/bash

if [ "$1" == "--help" ]; then
	# Display usage information
	echo "Usage: ./script_name.sh DIRECTORY_NAME DEV_PATH"
	echo "Automatically mounts drives depending on command line arguments."
	echo "  DIRECTORY_NAME: Name of the directory to be created and mounted."
	echo "  DEVICE_PATH:    Path of the device to be mounted."
	exit 0
fi

# Check if required arguments are provided
if [ "$#" -ne 2 ]; then
	echo "Error: Invalid number of arguments. Use --help for usage information."
	exit 1
fi

# Step 1: Create Directory
echo -e "[\033[38;5;200m sudo mkdir $1 \033[0m]"
sudo mkdir "$1"

echo -e "[\033[38;5;200m sudo chown -R joona:joona \033[0m]"
sudo chown -R joona:joona "$1"

echo -e "[\033[38;5;200m sudo chmod -R 744 $1 \033[0m]"
sudo chmod -R 744 "$1"

# Step 2: Get UUID
echo -e "[\033[38;5;200m sudo blkid UUID == $(sudo blkid -s UUID -o value "$2") \033[0m]"
uuid=$(blkid -s UUID -o value "$2")

echo -e "[\033[38;5;200m sudo blid type == $(blkid -s TYPE -o value "$2") \033[0m]"
type=$(blkid -s TYPE -o value "$2")

1
echo -e "[\033[1;32m#$1 \033[0m]"
echo -e "\n#$1" >> /etc/fstab

echo -e "[\033[38;5;200m UUID=$uuid $1 $type defaults 0 0\033[0m]"
echo "UUID=$uuid $1 $type defaults 0 0" >> /etc/fstab

# Step 4: Mount Drives
echo -e "[\033[38;5;200m sudo mount -a \033[0m]"
systemctl daemon-reload
sudo mount -a
