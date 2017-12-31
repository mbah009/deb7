#
#!/bin/bash
#Script create akaun trial
#
#
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
cd
clear
echo "==================================================================="
echo -e "             TRIAL USER MENU | MENU SCRIPT BY NS                "
echo "==================================================================="
echo ""
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
hari="1"
Pass=`</dev/urandom tr -dc a-f0-9 | head -c9`

useradd -e `date -d "$hari days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "====Trial akaun===="
echo -e "Host: $MYIP" 
echo -e "Port SSL SSH: 442"
echo -e "Port SSL Dropbear: 443"
echo -e "Port Squid: 8080"
echo -e "Config OpenVPN (TCP 1194): http://$MYIP/client.ovpn"
echo -e "Username: $Login"
echo -e "Password: $Pass\n"
echo "==================================================================="
echo ""
