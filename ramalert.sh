#!/bin/sh
threshold1=50
FREE=$(($(free -m | awk 'NR==2 {print $4}') * 100 ))
echo $FREE
USAGE=$(($FREE / 4314 ))
echo $USAGE
if [ $USAGE -ge $threshold1 ] ; then
       echo "Warnig: Ram utilization reach threshold"
else 
       echo "Ram is under threshold limt"
fi
