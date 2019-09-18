#!/bin/bash

####
# This script automatically creates SFTP Account and allow only access to Home Directory
#
# Author: Asuk Nath
# Date: 11/20/15
#
###

# Check user name supplied or not
if [ $# -lt 1 ]; then
echo "Please supply a username"
echo "Example: " $0 "john"
exit
fi

# Check if username already exist
if id "$1" >/dev/null 2>&1; then
 echo "Username Exists"
 echo "Use different username"
 exit
fi

# Declare local variable and generate random password for SFTP
newuser=$1
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# Create new user and assign random password.
useradd $newuser
echo $newuser:$randompw | chpasswd

# Setting folder permission
echo "Please wait Applying Permission and setting Incoming folder"

mkdir /home/$newuser
chown root:root /home/$newuser
sleep 2
mkdir /home/$newuser/sftproot
sleep 2
chown $newuser:$newuser /home/$newuser/sftproot

cat <<EOF >> /etc/ssh/sshd_config
Match User $newuser
ChrootDirectory /home/$newuser/
 ForceCommand internal-sftp
 AllowTCPForwarding no
 X11Forwarding no
EOF

sleep 2
service ssh restart

# New Username and Password to account.txt

cat <<EOF >> /home/account.txt
$newuser $randompw
EOF

echo "SFTP Account:" $newuser "has been created with the password:" $randompw