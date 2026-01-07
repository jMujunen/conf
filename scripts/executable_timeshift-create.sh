#!/bin/bash
#
# Usage:
#	./timeshift-create.sh --comments <comment> --tag <tag> <DEVICE>
#
# Parameters:
# -----------
#	comments (Optional): Comment for the snapshot
#	tag (Optional): Add a tag
#	device (Default=/dev/sda2)

printhelp() {
    echo "Usage: ./timeshift-create.sh --comments <comment> --tags <tag>  --device (/dev/sda2)"
    echo "Parameters:"
    echo "-----------"
    echo "comments (Optional):  Comment for the snapshot"
    echo "tags (Optional):      Add a tag"
    echo "device (Optional):    Snapshot device/partition (Default=/dev/sda2)"
    exit 1
}
if [[ $# -eq 0 ]]; then
    sudo timeshift --create --comments "" --snapshot-device /dev/sda2 --rsync
    exit 0
fi
if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
    printhelp
else
    comments=""
    tag=""
    device="/dev/sda2"

    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            -c*)
                comments="$2"
                shift
                shift
                ;;
            -t*)
                tag="$2"
                shift
                shift
                ;;
            -d*)
                device="$2"
                shift
                shift
                ;;
            # "--skip-grub"
            *)
                printhelp
                ;;
        esac
    done

fi

if [[ "$tag" == "" ]]; then
    sudo timeshift --create --comments "$comments" --snapshot-device "$device" --rsync
    exit 0
else
    sudo timeshift --create --comments "${comments}" --tags "${tag}" \
        --snapshot-device "${device}" --rsync
    exit 0
fi
