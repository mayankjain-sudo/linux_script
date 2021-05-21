#!/bin/sh

# httpd installation and Setup Script

# Author Mayank Jain

# Date: 14/06/2020

echo

echo -e "\033[34m   Notice:- ***** Run script for Linux servers Only ***** \033[0m"

echo

echo "\033[31mNotice:-Please Look For Green Output After Yellow Output for Successfully httpd setup.!\033[0m"

read -p "Press Enter to Continue !!! " -n1 -s

echo

echo -e "\033[035m############################## TAKING BACKUP OF /etc Directory ##################################\033[0m"

echo -e "\033[36mTaking full backup of /etc \033[0m"

echo -e "\033[36mStatus is :\033[0m"

ls -l /etc/*.org.tgz &>/dev/null

if [ $? -eq 0 ]; then

	echo -e "\033[32m/etc directory backup is already taken\033[0m"

	ls -l /etc/*.org.tgz
else
	echo -e "\033[33mTaking backup of /etc directory\033[0m"

	tar -zcvf /etc/etc.`date +%d.%m.%Y`.org.tgz /etc/ &> /dev/null

if [ $? -eq 1 ]; then
	
	echo -e "\033[32mBackup of /etc directory compeleted Successfully\033[0m"

	ls -l /etc/*.org.tgz
else
	echo -e "\033[31mBackup of /etc directory take manually and press Enter\033[0m"

	read -p "Press Enter..." -n1 -s
	 
		sleep 5 
fi 

fi

echo -e "\033[35m.........................................................................................................\033[0m"

##############################################################################################################################################
echo -e "\033[035m############################## Installing httpd #############################################\033[0m"

echo -e "\033[36mInstalling httpd... \033[0m"

echo -e "\033[36mStatus is :\033[0m"

yum install httpd -y

echo -e "\033[32mhttpd is installed successfully\033[0m"
###############################################################################################################################################
echo -e "\033[035m############################## Enabling firewalld #############################################\033[0m"

echo -e "\033[36mEnabling firewalld... \033[0m"

echo -e "\033[36mStatus is :\033[0m"

systemctl enable firewalld

echo -e "\033[32mfirewalld enabled successfully\033[0m"
##############################################################################################################################################

echo -e "\033[035m############################## Starting firewalld #############################################\033[0m"

echo -e "\033[36mStarting firewalld... \033[0m"

echo -e "\033[36mStatus is :\033[0m"

systemctl start firewalld

echo -e "\033[32mfirewalld Started successfully\033[0m"
##############################################################################################################################################

echo -e "\033[035m############################## Opening ports for http and https in firewalld #############################################\033[0m"

echo -e "\033[36mOpening ports for http and https in firewalld... \033[0m"

echo -e "\033[36mStatus is :\033[0m"

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https

echo -e "\033[32mPorts for http and https are opened in firewalld successfully\033[0m"
##############################################################################################################################################
echo -e "\033[035m############################## Reloading firewalld #############################################\033[0m"

echo -e "\033[36mReloading firewalld... \033[0m"

echo -e "\033[36mStatus is :\033[0m"

firewall-cmd --reload

echo -e "\033[32mPorts for http and https are opened in firewalld successfully\033[0m"

##############################################################################################################################################
echo -e "\033[035m############################## Starting httpd Service #############################################\033[0m"

echo -e "\033[36mStarting httpd Service... \033[0m"

echo -e "\033[36mStatus is :\033[0m"

systemctl enable httpd

systemctl start httpd

systemctl reload httpd

echo -e "\033[32mhttpd Service started successfully\033[0m"


echo -e "\033[35m..........................................................................................................\033[0m"

#---------------------------------------------------------------------------------------------------------------------------------#


#--------------------------------------------------------------------------------------------------------------------------------#

echo -e "\033[35m Installation Completed\033[0m"
