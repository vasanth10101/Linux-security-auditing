#!/bin/bash

# Declare the file_system as an array with individual elements
file_system=("/home" "/tmp" "/var/tmp" "var/lib" "var/log")

# Check for symbolic links
for dir in "${file_system[@]}"; do
    if [ -L "$dir" ]; then
        echo "You should check the symbolic link in the $dir directory"
    else 
        echo " $dir  doesn't have any symbolic link"
fi
done

for dir in "${file_system[@]}"; do
  k=  mount | awk -v dir="$dir" '$3 == dir {print $3}'

done

if [ -z $k ];then
        echo "No mounted directory found"

fi
# -----------------------------------------------------------------------------
#The script you shared is designed to check for Logical Volume Manager (LVM) volume groups
# Check if both vgdisplay and lsvg commands exist
if [ -e /usr/sbin/vgdisplay ] && [ -e /usr/sbin/lsvg ]; then
    pre="YES"
else
    pre="NO"
fi

echo "Checking the LVM volume groups"

# Execute vgdisplay and process its output
find=$(vgdisplay 2> /dev/null | grep -v "No volume groups found" | grep "VG Name" | awk '{pr>

# Check if any volume groups were found
if [ -n "$find" ]; then
    echo "Found one or more volume groups"
    for i in $find; do
        echo "Found LVM volume group: $i"
    done
else
    echo "No volume groups found"
fi

