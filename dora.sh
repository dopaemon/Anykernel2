# DoraCore Kernel Modules Flasher
OUTFD=/proc/self/fd/$1;
CODENAME=$(getprop ro.product.device)

## Start Function
# ui_print <text>
ui_print() {
   echo -e "ui_print $1\nui_print" > $OUTFD;
}
## End Function

# Print Device Codename
ui_print " Device: ${CODENAME}";

# Print Slot Device
ui_print " Slot: ${SLOT}";

# Variable
VENDOR_DLKM_IMG=/data/dora/vendor_dlkm${SLOT}.img;
VENDOR_BOOT_IMG=/data/dora/vendor_boot${SLOT}.img;
VENDOR_DLKM_BLOCK=/dev/block/mapper/vendor_dlkm${SLOT};
VENDOR_BOOT_BLOCK=/dev/block/by-name/vendor_boot${SLOT};
VENDOR_DLKM_POINT=/data/dora/mount/vendor/dlkm;
VENDOR_BOOT_POINT=/data/dora/mount/vendor/boot;
LOOP_DLKM="*";
LOOP_BOOT="*";

# Backup vendor_dlkm partition
ui_print " Partition: Backup vendor_dlkm";
dd if=${VENDOR_DLKM_BLOCK} \
   of=${VENDOR_DLKM_IMG};

# Backup vendor_boot partition
ui_print " Partition: Backup vendor_boot";
dd if=${VENDOR_BOOT_BLOCK} \
   of=${VENDOR_BOOT_IMG};

# Send images to sdcard
ui_print " Create Backup Folder";
rm -rf /sdcard/DoraBackup;
mkdir -p /sdcard/DoraBackup;
cp -r ${VENDOR_DLKM_IMG} \
      /sdcard/DoraBackup/;
cp -r ${VENDOR_BOOT_IMG} \
      /sdcard/DoraBackup/;

# Create mount point vendor_dlkm
ui_print " Create vendor/dlkm mount point";
mkdir -p ${VENDOR_DLKM_POINT};

# Create mount point vendor_boot
ui_print " Create vendor/boot mount point";
mkdir -p ${VENDOR_BOOT_POINT};

# Setup loop mount
ui_print " Create loop device vendor/dlkm";
LOOP_DLKM=$(losetup -fP --show ${VENDOR_DLKM_IMG});
LOOP_BOOT=$(losetup -fP --show ${VENDOR_BOOT_IMG});
ui_print "  - vendor dlkm: ${LOOP_DLKM}";
ui_print "  - vendor boot: ${LOOP_BOOT}";
ui_print " ";

# Mount loop to point
ui_print " Mount loop vendor dlkm";
mount ${LOOP_DLKM} ${VENDOR_DLKM_POINT};
ui_print " Mount loop vendor boot";
mount ${LOOP_BOOT} ${VENDOR_BOOT_POINT};

# Remove Install file
rm -rf /data/dora;

## Install Done ##
