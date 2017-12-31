#!/bin/bash
# ====================================
# 
# ====================================

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/mbah009/deb7/master/sources.list.debian7"
wget "http://www.dotdeb.org/dotdeb.gpg"
wget "http://www.webmin.com/jcameron-key.asc"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update
apt-get update

# install webserver
apt-get -y install nginx

# install essential package
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs cron stunnel4 openvpn less screen psmisc apt-file whois ptunnel ngrep mtr git zsh snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

#Install Figlet
apt-get install figlet
echo "clear" >> .bashrc
echo 'echo -e ""' >> .bashr
echo 'echo -e ""' >> .bashrc
echo 'figlet -k "NS-SSH"' >> .bashrc
echo 'echo -e ""' >> .bashrc
echo 'echo -e "     ========================================================="' >> .bashrc
echo 'echo -e "     *                 Script By NS | NS-SSH                 *"' >> .bashrc
echo 'echo -e "     ========================================================="' >> .bashrc
echo 'echo -e "     *                     Contact Me                        *"' >> .bashrc
echo 'echo -e "     *                 Telegram: @root_security              *"' >> .bashrc
echo 'echo -e "     ========================================================="' >> .bashrc
echo 'echo -e "     *        Taip \033[1;32mmenu\033[0m untuk menampilkan senarai menu       *"' >> .bashrc
echo 'echo -e "     ========================================================="' >> .bashrc
echo 'echo -e ""' >> .bashrc

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/mbah009/deb7/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by NS-SSH | NS-SSH-VPN</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/mbah009/deb7/master/vps.conf"
service nginx restart

# install openvpn
wget -O /etc/openvpn/openvpn.tar "https://raw.githubusercontent.com/mbah009/deb7/master/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/mbah009/deb7/master/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/mbah009/deb7/master/iptables"
chmod +x /etc/network/if-up.d/iptables
service openvpn restart

#konfigurasi openvpn
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/mbah009/deb7/master/client-1194.conf"
sed -i $MYIP2 /etc/openvpn/client.ovpn;
cp client.ovpn /home/vps/public_html/

cd
# install badvpn
wget -O /usr/bin/badvpn-udpgw "https://github.com/mbah009/deb7/raw/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "https://github.com/mbah009/deb7/raw/master/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# banner ssh
cd
wget https://github.com/mbah009/deb7/raw/master/banner-ssh
echo "Banner /etc/banner-ssh" >> /etc/ssh/sshd_config

# install dropbear / banner
cd
apt-get install zlib1g-dev
wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2017.75.tar.bz2
bzip2 -cd dropbear-2017.75.tar.bz2  | tar xvf -
cd dropbear-2017.75
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear1
ln /usr/local/sbin/dropbear /usr/sbin/dropbear
cd
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_BANNER=""/DROPBEAR_BANNER="banner-ssh"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# install fail2ban
cd
apt-get -y install fail2ban;service fail2ban restart

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'
cd

# install stunnel
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/mbah009/deb7/master/stunnel.conf"
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4

# install squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/mbah009/deb7/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install webmin
wget -O webmin-current.deb "http://www.webmin.com/download/deb/webmin-current.deb"
dpkg -i --force-all webmin-current.deb;
apt-get -y -f install;
rm /root/webmin-current.deb

# auto restart server 12.01 am
wget -O reboot.sh "https://raw.githubusercontent.com/mbah009/deb7/master/reboot.sh"
chmod +x /root/reboot.sh
echo "0 0 * * * root /root/reboot.sh" > /etc/cron.d/reboot

# download script
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/mbah009/deb7/master/menu.sh"
wget -O 1 "https://raw.githubusercontent.com/mbah009/deb7/master/user-add.sh"
wget -O 2 "https://raw.githubusercontent.com/mbah009/deb7/master/trial.sh"
wget -O 3 "https://raw.githubusercontent.com/mbah009/deb7/master/user-gen.sh"
wget -O 4 "https://raw.githubusercontent.com/mbah009/deb7/master/user-list.sh"
wget -O 5 "https://raw.githubusercontent.com/mbah009/deb7/master/user-pass.sh"
wget -O 6 "https://raw.githubusercontent.com/mbah009/deb7/master/user-renew.sh"
wget -O 7 "https://raw.githubusercontent.com/mbah009/deb7/master/user-del.sh"
wget -O 8 "https://raw.githubusercontent.com/mbah009/deb7/master/userexpired.sh"
wget -O 9 "https://raw.githubusercontent.com/mbah009/deb7/master/user-expire-list.sh"
wget -O 10 "https://raw.githubusercontent.com/mbah009/deb7/master/delete-user-expire.sh"
wget -O 11 "https://raw.githubusercontent.com/mbah009/deb7/master/user-banned.sh"
wget -O 12 "https://raw.githubusercontent.com/mbah009/deb7/master/user-unbanned.sh"
wget -O 13 "https://raw.githubusercontent.com/mbah009/deb7/master/user-login.sh"
wget -O 14 "https://raw.githubusercontent.com/mbah009/deb7/master/userlimit.sh"
wget -O 15 "https://raw.githubusercontent.com/mbah009/deb7/master/userlimitssh.sh"
wget -O 16 "https://raw.githubusercontent.com/mbah009/deb7/master/ssh-1.sh"
wget -O 17 "https://raw.githubusercontent.com/mbah009/deb7/master/ssh-2.sh"
wget -O 18 "https://raw.githubusercontent.com/mbah009/deb7/master/ps_mem.py"
wget -O 19 "https://raw.githubusercontent.com/mbah009/deb7/master/resvis.sh"
wget -O 20 "https://raw.githubusercontent.com/mbah009/deb7/master/speedtest_cli.py"
wget -O 21 "https://raw.githubusercontent.com/mbah009/deb7/master/benchmark.sh"
wget -O 22 "https://raw.githubusercontent.com/mbah009/deb7/master/info.sh"
wget -O 23 "https://raw.githubusercontent.com/mbah009/deb7/master/about.sh"
wget -O 24 "https://raw.githubusercontent.com/mbah009/deb7/master/rebootserver.sh"
wget "https://raw.githubusercontent.com/mbah009/deb7/master/autokill.sh"
wget "https://raw.githubusercontent.com/mbah009/deb7/master/userlimit.sh"
wget "https://raw.githubusercontent.com/mbah009/deb7/master/userlimitssh.sh"
screen -AmdS check /usr/bin/autokill.sh
sed -i '$ i\screen -AmdS check /usr/bin/autokill.sh' /etc/rc.local
sed -i '$ i\touch /var/lock/subsys/local' /etc/rc.local

chmod +x menu
chmod +x 1
chmod +x 2
chmod +x 3
chmod +x 4
chmod +x 5
chmod +x 6
chmod +x 7
chmod +x 8
chmod +x 9
chmod +x 10
chmod +x 11
chmod +x 12
chmod +x 13
chmod +x 14
chmod +x 15
chmod +x 16
chmod +x 17
chmod +x 18
chmod +x 19
chmod +x 20
chmod +x 21
chmod +x 22
chmod +x 23
chmod +x 24
chmod +x autokill.sh
chmod +x userlimit.sh
chmod +x userlimitssh.sh
cd

#bonus block playstation
iptables -A OUTPUT -d account.sonyentertainmentnetwork.com -j DROP
iptables -A OUTPUT -d auth.np.ac.playstation.net -j DROP
iptables -A OUTPUT -d auth.api.sonyentertainmentnetwork.com -j DROP
iptables -A OUTPUT -d auth.api.np.ac.playstation.net -j DROP
iptables-save

#bonus block torrent
iptables -A INPUT -m string --algo bm --string "BitTorrent" -j REJECT
iptables -A INPUT -m string --algo bm --string "BitTorrent protocol" -j REJECT
iptables -A INPUT -m string --algo bm --string "peer_id=" -j REJECT
iptables -A INPUT -m string --algo bm --string ".torrent" -j REJECT
iptables -A INPUT -m string --algo bm --string "announce.php?passkey=" -j REJECT
iptables -A INPUT -m string --algo bm --string "torrent" -j REJECT
iptables -A INPUT -m string --algo bm --string "info_hash" -j REJECT
iptables -A INPUT -m string --algo bm --string "/default.ida?" -j REJECT
iptables -A INPUT -m string --algo bm --string ".exe?/c+dir" -j REJECT
iptables -A INPUT -m string --algo bm --string ".exe?/c_tftp" -j REJECT
iptables -A INPUT -m string --string "peer_id" --algo kmp -j REJECT
iptables -A INPUT -m string --string "BitTorrent" --algo kmp -j REJECT
iptables -A INPUT -m string --string "BitTorrent protocol" --algo kmp -j REJECT
iptables -A INPUT -m string --string "bittorrent-announce" --algo kmp -j REJECT
iptables -A INPUT -m string --string "announce.php?passkey=" --algo kmp -j REJECT
iptables -A INPUT -m string --string "find_node" --algo kmp -j REJECT
iptables -A INPUT -m string --string "info_hash" --algo kmp -j REJECT
iptables -A INPUT -m string --string "get_peers" --algo kmp -j REJECT
iptables -A INPUT -p tcp --dport 25 -j REJECT   
iptables -A FORWARD -p tcp --dport 25 -j REJECT 
iptables -A OUTPUT -p tcp --dport 25 -j REJECT 
iptables-save

# finalisasi
chown -R www-data:www-data /home/vps/public_html
service nginx start
service php-fpm start
service openvpn restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart
service cron restart
/etc/init.d/stunnel4 restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile
rm -f /root/debian7.sh

# info
clear
echo "===========================================" | tee -a log-install.txt
echo "        Autoscript ini mengandungi:        " | tee log-install.txt
echo "===========================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Servis"  | tee -a log-install.txt
echo "------"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$MYIP/client.ovpn)"  | tee -a log-install.txt
echo "SSL SSH  : 442"  | tee -a log-install.txt
echo "SSL Dropbear : 443"  | tee -a log-install.txt
echo "Squid3   : 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Tools"  | tee -a log-install.txt
echo "-----"  | tee -a log-install.txt
echo "axel"  | tee -a log-install.txt
echo "bmon"  | tee -a log-install.txt
echo "htop"  | tee -a log-install.txt
echo "iftop"  | tee -a log-install.txt
echo "mtr"  | tee -a log-install.txt
echo "nethogs"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Fungsi lain"  | tee -a log-install.txt
echo "-----------"  | tee -a log-install.txt
echo "Webmin   : http://$MYIP:10000/"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "Autokill : [on]"  | tee -a log-install.txt
echo "IPv6     : [off]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Maklumat Tambahan"  | tee -a log-install.txt
echo "-----------------"  | tee -a log-install.txt
echo "VPS AUTO REBOOT JAM 12 TENGAH MALAM"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Original Script by NS | NS-SSH"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Installation log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "==========================================="  | tee -a log-install.txt
cd

