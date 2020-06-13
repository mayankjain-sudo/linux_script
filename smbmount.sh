sudo mkdir /mnt/dbfileshare
if [ ! -d "/etc/smbcredentials" ]; then
sudo mkdir /etc/smbcredentials
fi
if [ ! -f "/etc/smbcredentials/dbfileshare.cred" ]; then
    sudo bash -c 'echo "username=dbfileshareusername" >> /etc/smbcredentials/dbfileshare.cred'
    sudo bash -c 'echo "password=MvusZrltYNH1c2bhgcttfyghvjhbgtOp211JjEqHWPy+e2LcXPx8L6gHX2OIgI5TNWcgS8YTg==" >> /etc/smbcredentials/dbfileshare.cred'
fi
sudo chmod 600 /etc/smbcredentials/dbfileshare.cred

sudo bash -c 'echo "//dbfileshare.file.core.windows.net/dbfileshare /mnt/dbfileshare cifs nofail,vers=3.0,credentials=/etc/smbcredentials/dbfileshare.cred,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
sudo mount -t cifs //dbfileshare.file.core.windows.net/dbfileshare /mnt/dbfileshare -o vers=3.0,credentials=/etc/smbcredentials/dbfileshare.cred,dir_mode=0777,file_mode=0777,serverino
