echo -e "\033[035m############################## TAKING BACKUP OF /etc Directory ###############################\033[0m"

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
