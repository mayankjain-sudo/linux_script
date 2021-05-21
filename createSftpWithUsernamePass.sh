#!/bin/bash

# This script will creates SFTP Account and allow only access to Home Directory

# Author: Mayank Jain

# Date: 11/20/15

echo

echo -e "\033[34m   Notice:- ***** Run script for Linux servers Only ***** \033[0m"

echo

echo "\033[31mNotice:-Please Look For Green Output After Yellow Output for Successfully SFTP setup.!\033[0m"

read -p "Press Enter to Continue !!! " -n1 -s

echo

echo "\033[31mThis script will creates SFTP Account and allow only access to Home Directory\033[0m"

echo -e "\033[36mChecking username is passed or not. \033[0m"

echo -e "\033[36mStatus is :\033[0m"
sleep 2
if [ $# -lt 1 ]; then
echo -e "\033[32mPlease pass a username\033[0m"
echo -e "\033[32m "Example: " $0 "mayank"\033[0m"]
exit
fi

echo -e "\033[36mChecking username is already present or not. \033[0m"

echo -e "\033[36mStatus is :\033[0m"
sleep 2
if id "$1" >/dev/null 2>&1; then
 echo -e "\033[32mUsername Exists\033[0m"
 echo -e "\033[32mUse different username\033[0m"
 exit
fi

echo -e "\033[36mGenerating Random password for new User. \033[0m"

echo -e "\033[36mStatus is :\033[0m"
newuser=$1
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
echo -e "\033[32mPassword generated Successfully\033[0m"

# Create new user and assign random password.
useradd $newuser
echo $newuser:$randompw | chpasswd

echo -e "\033[36mApplying Permission and setting for folder. \033[0m"

echo -e "\033[36mStatus is :\033[0m"

mkdir /home/$newuser
chown root:root /home/$newuser
sleep 5
mkdir /home/$newuser/sftproot
sleep 5
chown $newuser:$newuser /home/$newuser/sftproot

cat <<EOF >> /etc/ssh/sshd_config
Match User $newuser
ChrootDirectory /home/$newuser/
 ForceCommand internal-sftp
 AllowTCPForwarding no
 X11Forwarding no
EOF

sleep 5
service ssh restart

echo -e "\033[32mSettings are applied.\033[0m"

echo -e "\033[36mCredentials file is creating for SFTP at location /home/account.txt \033[0m"

echo -e "\033[36mStatus is :\033[0m"

cat <<EOF >> /home/account.txt
$newuser $randompw
EOF

echo -e "\033[32m"SFTP Account:" $newuser "has been created with the password:" $randompw \033[0m"