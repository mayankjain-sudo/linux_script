#!/bin/bash
threshold=80
available=$( df -h | awk 'NR==4 {print $5}' | tr -d '%' )
if [ $available -ge $threshold ] ; then
	echo "Disk space running out"
else
	echo "Disk space is normal"
fi
