# DoraCore Kernel Modules Flasher
OUTFD=/proc/self/fd/$1;
CODENAME=$(getprop ro.product.device)

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

# Print Device Codename
ui_print " Device: ${CODENAME}";

# Print Slot Device
ui_print " Slot: ${SLOT}"

# Backup vendor_dlkm partition
ui_print " Partition: Backup vendor_dlkm"
dd if=/dev/block/mapper/vendor_dlkm${SLOT} \
   of=/data/dora/vendor_dlkm${SLOT}.img

# Backup vendor_boot partition
ui_print " Partition: Backup vendor_boot"
dd if=/dev/block/by-name/vendor_boot${SLOT} \
   of=/data/dora/vendor_boot${SLOT}.img

# Send images to sdcard
ui_print " Create Backup Folder"
rm -rf /sdcard/DoraBackup
mkdir -p /sdcard/DoraBackup
cp -r /data/dora/vendor_dlkm${SLOT}.img /sdcard/DoraBackup/
cp -r /data/dora/vendor_boot${SLOT}.img /sdcard/DoraBackup/

# Remove Install file
rm -rf /data/dora;

## Install Done ##
