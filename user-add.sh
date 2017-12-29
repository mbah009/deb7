#
#!/bin/bash
#Script menambah user ssh
#
#
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
cd
clear
echo "==================================================================="
echo -e "            DAFTAR PELANGGAN                "
echo "==================================================================="
echo -e ""
read -p "Username : " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "Username [$username] sudah ada!"
	exit 1
else
	read -p "Password [$username] : " password
	read -p "Berapa hari akaun [$username] aktif: " AKTIF
	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd
	echo ""
	echo "-------------------------------------------------------------------"
	echo "Data Login:"
	echo "-------------------------------------------------------------------"
	echo "Host/IP: $MYIP"
	echo "SSL Dropbear Port: 443"
	echo "SSL SSH Port: 442"
	echo "Squid Proxy: 8080"
	echo "OpenVPN Config: http://$MYIP:81/client.ovpn"
	echo "Username: $username"
	echo "Password: $password"
	echo "Aktif sehingga: $(date -d "$AKTIF days" +"%d-%m-%Y")"
  echo -e ""
  echo "==================================================================="
  echo -e ""
fi
