#!/bin/bash

# nextboot.sh - Reboots the system with the specified boot loader entry
# DEPS
# ----
# bat, efibootmgr, fzf, bootctl

win_boot_id=0001
sb=0003
uki=0002

function next_boot() {
    if [ "$#" -eq 0 ]; then
        #sudo systemctl reboot --boot-loader-entry=archwayland.conf
        sudo efibootmgr \
            | grep -Po "BootOrder.*|Boot\d{4}\*\s(\w{4,}\s)+" \
            | bat -pl less --theme=TwoDark

    fi
    if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
        echo "Usage: nextboot.sh [OPTIONS] BOOT_LOADER_ENTRY"
        echo "Reboots the system with the specified boot loader entry."
        echo
        echo "Options:"
        echo -e "\t-c , --choose Choose the next boot loader entry with fzf"
        echo -e "\t-l , --list List available boot loader entries"
        echo -e "\t-h , --help Show this help message"
        echo -e "Quick Dial:"
        printf "\t%-10s%s\n" "efi" "Reboots in UEFI interface"
        printf "\t%-10s%s\n" "windows" "Reboots to configured windows bootid - $win_boot_id"
        return 0
    fi
    if [ "$1" == "-c" ] || [ "$1" == "--choose" ]; then
        sudo efibootmgr | grep -Po "BootOrder.*|Boot\d{4}\*\s(\w{4,}\s)+" \
            | bat -pl less --theme=TwoDark \
            | fzf -m 1 \
            | awk '{print $2}' \
            | xargs sudo efibootmgr --bootnext
    fi
    if [ "$1" == "-l" ] || [ "$1" == "--list" ]; then
        sudo efibootmgr | grep -Po "BootOrder.*|Boot\d{4}\*\s(\w{4,}\s)+" \
            | bat -pl less --theme=TwoDark

        if [ "$?" == 1 ]; then
            . ~/.bash_functions
            error "Failed to list boot loader entries."
            error "Does the path exist?"
            return 1
        fi
        return 0
    elif [ "$1" == "efi" ]; then
        sudo bootctl reboot-to-firmware true
        bootid="efi"
    elif [ "$1" == "windows" ]; then
        bootid=0001
        sudo efibootmgr --bootnext 0001 > /dev/null 2>&1
    else
        bootid="$1"
        sudo efibootmgr --bootnext "$1" > /dev/null 2>&1
    fi
    if [ $? -eq 0 ]; then
        if [ "$bootid" == "efi" ]; then
            bootlabel="EFI Firmware"
        else
            bootlabel=$(efibootmgr | grep Boot"$bootid" | sed -E 's/Boot.....?.?(.*)HD.*/\1/g')
        fi
        echo -e "\033[32mSelected $bootid - $bootlabel\033[0m"
        echo "Reboot now? [Y/n]: "
        read -r answer
        if [[ $answer =~ ^[Yy]?$|^$ ]]; then
            # if [[ -f ~/scripts/shutdown/force_kill.sh ]]; then
                # ~/scripts/shutdown/force_kill.sh
            # fi
            /bin/bash /home/joona/scripts/shutdown/move_boot_hwinfo.sh
            sudo systemctl reboot
        else
            echo -e "\033[33mNext boot set - $bootlabel\033[0m"
            return 0
        fi
    else
        echo -e "\033[31mError: Invalid number of arguments. Use --help for usage information.\033[0m"
        return 1
    fi
}

if which bat >/dev/null && \
	which efibootmgr >/dev/null && \
	which fzf >/dev/null && \
	which bootctl >/dev/null; then
		next_boot "$@"

else
	echo -e "\033[31mError: Script requires efibootmgr, bootctl"
	echo -e "and is configured to use opt-deps fzf and bat\033[0m"
fi

