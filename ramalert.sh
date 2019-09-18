#!/bin/bash

threshold=90
threshold2=95

freemem=$(($(free -m |awk 'NR==2 {print $3}') * 100))

usage=$(($freemem / 8192))

if [ "$usage" -gt "$threshold" ]

then

/etc/init.d/apache2 restart

     if [ "$usage" -gt "$threshold2" ]

     then

     echo "The memory usage has reached $usage% on $HOSTNAME." | mail -s "High Memory Usage Alert" abc@xyz.com


     fi
fi
