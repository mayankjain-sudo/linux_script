#end an Email Alert When Your Disk Space Gets Low
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=85

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Disk Space Alert for your Server' abc@xyz.com << EOF
Your Server is facing low disk space issue, free space is critically low. Used: $CURRENT%
EOF
fi

