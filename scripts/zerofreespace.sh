#!/bin/sh
 
# Should go last, throws 0's at any free space
# helps trim the size of things.
slash=$(df -h / | tail -n 1 | awk '{print $1}')
echo diskutil secureErase freespace 0 ${slash}
diskutil secureErase freespace 0 ${slash}
