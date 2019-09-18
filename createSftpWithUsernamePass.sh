#!/bin/bash

# This script automatically creates SFTP Account and allow only access to Home Directory
#Author : Mayank Jain

# Check user name and password supplied or not
if [ $# -lt 2 ]; then
echo "Please supply a username and password"
echo "Example: " $0 "mayank" "password"
exit
fi

# Check if username already exist or not
if id "$1" >/dev/null 2>&1; then
 echo "Username already Exists. Use different username"
 exit
fi

# Declare local variable for SFTP
newuser=$1

# Create new user and assign password.
useradd $newuser
echo $newuser:$2 | chpasswd

# Setting folder permission
echo "Applying Permission and setting for Incoming folder"

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

# Maintaing Username and Password in sftpUserDetails.txt

cat <<EOF >> /home/sftpUserDetails.txt
$newuser $2
EOF

echo "SFTP Account:" $newuser "has been created with the password:" $2