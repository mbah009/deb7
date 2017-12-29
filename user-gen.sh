#
#!/bin/bash
#Script generate akaun
#
#
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
cd
clear
echo "==================================================================="
echo -e "         GENERATE AKAUN PELANGGAN           "
echo "==================================================================="
echo -e ""
read -p "Berapa jumlah akaun yang akan dibuat: " JUMLAH
read -p "Berapa hari akaun aktif: " AKTIF
today="$(date +"%Y-%m-%d")"
expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
echo ""
echo "-------------------------------------------------------------------"
echo "Data Login:"
echo "-------------------------------------------------------------------"
echo "Host/IP: $MYIP"
echo "SSL Dropbear Port: 443"
echo "SSL SSH Port: 442"
echo "Squid Proxy: 8080"
echo "OpenVPN Config: http://$MYIP:81/client.ovpn"
for (( i=1; i <= $JUMLAH; i++ ))
do
	username=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1`;
	useradd -M -N -s /bin/false -e $expire $username
	#password=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1`;
	echo $username:$username | chpasswd
	
	echo "$i. Username/Password: $username"
done

echo "Aktif sehingga: $(date -d "$AKTIF days" +"%d-%m-%Y")"
echo -e ""
echo "==================================================================="
echo -e ""
