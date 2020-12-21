#Enabling auditd service:
echo -e "\033[035m############################## Enabling auditd service of system ###############################\033[0m"

echo -e "\033[36mEnabling auditd service:\033[0m"

echo -e "\033[36mStatus is :\033[0m"

services="auditd"

        arr=$(echo $services | tr " " "\n")

        for x in $arr

        do

        /sbin/chkconfig $x on &> /dev/null && echo -e "\033[32mService $x is enabled\033[0m" || echo -e "\033[33mService $x is present\033[0m"

        done

echo -e "\033[35m..........................................................................................................\033[0m"

echo -e "\033[035m############################## Taking Backup of Audit Rules File ###############################\033[0m"

echo -e "\033[36mTaking backup of /etc/audit/rules.d/audit.rules \033[0m"

echo -e "\033[36mStatus is :\033[0m"

ls -l /etc/audit/rules.d/*.org.tgz &>/dev/null

if [ $? -eq 1 ]; then

	echo -e "\033[32maudit.rules file backup is already taken\033[0m"

	ls -l /etc/audit/rules.d/*.org.tgz
else
	echo -e "\033[33mTaking backup of audit.rules file\033[0m"

	tar -zcvf /etc/audit/rules.d/audit.rules.`date +%d.%m.%Y`.org.tgz /etc/audit/rules.d/audit.rules &> /dev/null

if [ $? -eq 0 ]; then
	
	echo -e "\033[32mBackup of audit.rules file is compeleted Successfully\033[0m"

	ls -l /etc/audit/rules.d/*.org.tgz
else
	echo -e "\033[31mBackup of audit.rules file take manually and press Enter\033[0m"

	read -p "Press Enter..." -n1 -s
	 
		sleep 5 
fi

fi
echo -e "\033[35m..........................................................................................................\033[0m"

echo -e "\033[035m############################## Adding User Define Rules ###############################\033[0m"

echo -e "\033[36mSetting Rules for Audit:\033[0m"

echo -e "\033[36mStatus is :\033[0m"

echo "                                                  
-w /etc/passwd -p wa -k passwd_changes
-w /etc/group -p wa -k group_changes
-w /etc/shadow -p wa -k shadow_changes
-w /etc/sudoers -p wa -k sudoers_changes
-w /etc/selinux/ -p wa -k selinux_changes
-w /etc/hosts -p wa -k hosts_file_change
-w /etc/ssh/ -p rwa -k ssh_dir_access
-w /etc/fstab -p wa -k fstab_file_change" >> /etc/audit/rules.d/audit.rules

echo -e "\033[32mStandard Audit Rules are set\033[0m"

echo -e "\033[35m..........................................................................................................\033[0m"

echo -e "\033[035m############################## Restarting Auditd Service ###############################\033[0m"

echo -e "\033[33mRestarting Service Auditd\033[0m"

service="auditd"

        arr=$(echo $service | tr " " "\n")

        for x in $arr

        do

        service $x restart &> /dev/null && echo -e "\033[32mServices $x are restarted successfully\033[0m" || echo -e "\033[33mService $x are not present\033[0m"

        done


echo -e "\033[35m..........................................................................................................\033[0m"

echo -e "\033[035m############################## Rules added in Audit ###############################\033[0m"

echo -e "\033[36mRules added in Audit:\033[0m"

auditctl -l 

echo -e "\033[35m..........................................................................................................\033[0m"