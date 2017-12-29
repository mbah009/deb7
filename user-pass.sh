#
#!/bin/bash
#Script tukar password akaun SSH
#
#
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
cd
clear
echo "==================================================================="
echo -e "        TUKAR PASSWORD PELANGGAN            "
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

read -p "Masukkan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	read -p "Password baru untuk akaun [$username]: " password
	read -p "Sila masukkan semula password baru untuk akaun [$username]: " password1
	echo ""
	if [[ $password = $password1 ]]; then
		echo $username:$password | chpasswd
		echo "Password untuk akaun [$username] berjaya diganti"
		echo ""
		echo "-------------------------------------------------------------------"
		echo "Data Login:"
		echo "-------------------------------------------------------------------"
		echo "Host/IP: $MYIP"
		echo "SSL Dropbear Port: 443"
		echo "SSL OpenSSH Port: 442"
		echo "Squid Proxy: 8080"
		echo "OpenVPN Config: http://$MYIP:81/client.ovpn"
		echo "Username: $username"
		echo "Password: $password"
		#echo "Valid s/d: $(date -d "$AKTIF days" +"%d-%m-%Y")"
		echo "-------------------------------------------------------------------"
	else
		echo "Password untuk akaun [$username] gagal diganti"
		echo "[Password baru] & [Konfirmasi password baru] tidak sama, sila cuba semula!"
	fi
else
	echo "Username [$username] belum didaftarkan lagi!"
  echo -e ""
echo "==================================================================="
echo -e ""
	exit 1
fi
