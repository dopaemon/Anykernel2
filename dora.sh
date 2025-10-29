# Base Flashable With Erfan . Edit By Dopaemon

OUTFD=/proc/self/fd/$1;
CODENAME=$(getprop ro.product.device)

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

ui_print "Hello World !!!";
ui_print "${CODENAME}";

# Remove Install file
rm -rf /data/dora;

## Install Done ##
