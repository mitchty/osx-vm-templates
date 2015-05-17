#!/bin/bash

# Turn off hibernation and get rid of the sleepimage
pmset hibernatemode 0
rm -f /var/vm/sleepimage

# Stop the pager process and drop swap files. These will be re-created on boot
launchctl unload /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist
sleep 5
rm -rf /private/var/vm/swap*

slash="$(df -h / | tail -n 1 | awk '{print $1}')"
echo Zeroing out free space
diskutil secureErase freespace 0 ${slash}

# VMware Fusion specific items
if [ -e .vmfusion_version ] || [[ "$PACKER_BUILDER_TYPE" == vmware* ]]; then
    # Shrink the disk
    sudo /Library/Application\ Support/VMware\ Tools/vmware-tools-cli disk shrink /
fi
