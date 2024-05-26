#!/bin/bash

PERCENTAGE=80

disk_usage=`df -Ph | egrep '/dev/mapper' | awk '{print $5}' | sed s/%//g`

if [ $disk_usage -ge $PERCENTAGE ];
then
	echo "the root location approximately full"
else
	echo "ok"
fi
# 
