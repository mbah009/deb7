#
#!/bin/bash
#Script block akaun SSH
#
#
cd
clear
echo "==================================================================="
echo -e "          SEKAT AKAUN PELANGGAN          "
echo "==================================================================="
echo ""

# begin of user-list
echo "-------------------------------------------------------------------"
echo "USERNAME              EXP DATE     "
echo "-------------------------------------------------------------------"

while read expired
do
	AKUN="$(echo $expired | cut -d: -f1)"
	ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
	exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
	if [[ $ID -ge 1000 ]]; then
		printf "%-21s %2s\n" "$AKUN" "$exp"
	fi
done < /etc/passwd
echo "-------------------------------------------------------------------"
echo ""
# end of user-list

read -p "Masukkan username yang ingin disekat: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Adakah anda benar-benar ingin sekat akaun [$username] [y/n]: " -e -i y BANNED
	if [[ "$BANNED" = 'y' ]]; then
		echo " Akaun : $username" >> /root/banneduser.txt
		passwd -l $username
		echo ""
		echo "Akaun [$username] berjaya disekat!"
	else
		echo ""
		echo "Sekatan akaun [$username] dibatalkan!"
	fi
else
	echo "Username [$username] belum terdaftar!"
	echo -e ""
echo "==================================================================="
echo -e ""

	exit 1
fi
