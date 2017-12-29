#
#!/bin/bash
#Script block akaun SSH
#
#
cd
clear
echo "==================================================================="
echo -e "       BUKA SEKATAN AKAUN PELANGGAN         "
echo "==================================================================="
echo ""
echo "" > /root/banneduser.txt
read -p "Masukkan username yang ingin dibuka sekatan: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Adakah anda benar-benar ingin buka sekatan akaun [$username] [y/n]: " -e -i y BANNED
	if [[ "$BANNED" = 'y' ]]; then
		echo " Akaun : $username" >> /root/unbanneduser.txt
		passwd -u $username
		echo ""
		echo "Akaun [$username] berjaya dibuka sekatannya!"
	else
		echo ""
		echo "Pembukaan sekatan akaun [$username] dibatalkan!"
	fi
else
	echo "Username [$username] belum didaftarkan lagi!"
  echo -e ""
echo "==================================================================="
echo -e ""

	exit 1
fi
