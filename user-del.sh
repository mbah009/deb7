#
#!/bin/bash
#Script delete akaunSSH
#
#
cd
clear
echo "==================================================================="
echo -e "           PADAM AKAUN PELANGGAN          "
echo "==================================================================="
echo -e ""
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

read -p "Masukkan username yang ingin dipadam: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo ""
	read -p "Adakah anda benar-benar ingin memadam akaun [$username] [y/n]: " -e -i y REMOVE
	if [[ "$REMOVE" = 'y' ]]; then
		passwd -l $username
		userdel $username
		echo ""
		echo "Akaun [$username] berjaya dipadam!"
	else
		echo ""
		echo "Pemadaman akaun [$username] dibatalkan!"
	fi
else
	echo "Username [$username] belum didaftarkan lagi!"
  echo -e ""
echo "==================================================================="
echo -e ""

	exit 1
fi
