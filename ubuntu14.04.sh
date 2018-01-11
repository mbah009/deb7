#!/bin/bash
# initialisasi var
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# go to root
cd

# update
apt-get -y update

# install wget and curl
cd
apt-get update
apt-get -y install wget curl
sudo apt-get install ca-certificates

# install ssl
cd
apt-get install stunnel4 -y
wget -O /etc/stunnel/stunnel.conf "https://www.tmoe.shop/vpsdebian/config/stunnel.sh"
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4

# Change to Time GMT+8
cd
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# remove unused
cd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

#apt-get -y install
cd
apt-get -y install nano screen cron unzip

# update apt-file
cd
apt-file update

#install ovpn
cd
wget -q https://www.tmoe.shop/vpsdebian/openvpn.sh
mv ./openvpn.sh /usr/bin/openvpn.sh
chmod +x /usr/bin/openvpn.sh

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://www.tmoe.shop/vpsdebian/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# install dropbear
cd
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=3128/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

# install squid3
cd
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://www.tmoe.shop/vpsdebian/squid.conf"
sed -i $MYIP2 /etc/squid3/squid.conf

# install webmin
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.870_all.deb"
dpkg --install webmin_1.870_all.deb;
apt-get -y -f install;
rm /root/webmin_1.870_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf

# User Status
cd
wget https://www.tmoe.shop/vpsdebian/config/user-list.sh
mv ./user-list.sh /usr/local/bin/user-list.sh
chmod +x /usr/local/bin/user-list.sh

# Install Dos Deflate
cd
apt-get -y install dnsutils dsniff
wget https://www.tmoe.shop/vpsdebian/ddos-deflate-master.zip
unzip ddos-deflate-master.zip
cd ddos-deflate-master
./install.sh

# instal UPDATE SCRIPT
cd
wget https://www.tmoe.shop/vpsdebian/config/update.sh
mv ./update.sh /usr/bin/update.sh
chmod +x /usr/bin/update.sh

# instal Buat Akun SSH/OpenVPN
cd
wget https://www.tmoe.shop/vpsdebian/config/buatakun.sh
mv ./buatakun.sh /usr/bin/buatakun.sh
chmod +x /usr/bin/buatakun.sh

# instal Generate Akun SSH/OpenVPN
cd
wget https://www.tmoe.shop/vpsdebian/config/generate.sh
mv ./generate.sh /usr/bin/generate.sh
chmod +x /usr/bin/generate.sh

# instal Generate Akun Trial
cd
wget https://www.tmoe.shop/vpsdebian/config/trial.sh
mv ./trial.sh /usr/bin/trial.sh
chmod +x /usr/bin/trial.sh

# instal  Ganti Password Akun SSH/VPN
cd
wget https://www.tmoe.shop/vpsdebian/config/userpass.sh
mv ./userpass.sh /usr/bin/userpass.sh
chmod +x /usr/bin/userpass.sh

# instal Generate Akun SSH/OpenVPN
cd
wget https://www.tmoe.shop/vpsdebian/config/userrenew.sh
mv ./userrenew.sh /usr/bin/userrenew.sh
chmod +x /usr/bin/userrenew.sh

# instal Hapus Akun SSH/OpenVPN
cd
wget https://www.tmoe.shop/vpsdebian/config/userdelete.sh
mv ./userdelete.sh /usr/bin/userdelete.sh
chmod +x /usr/bin/userdelete.sh

# instal Cek Login Dropbear, OpenSSH & OpenVPN
cd
wget https://www.tmoe.shop/vpsdebian/config/userlogin.sh
mv ./userlogin.sh /usr/bin/userlogin.sh
chmod +x /usr/bin/userlogin.sh

# instal Auto Limit Multi Login
cd
wget https://www.tmoe.shop/vpsdebian/config/autolimit.sh
mv ./autolimit.sh /usr/bin/autolimit.sh
chmod +x /usr/bin/autolimit.sh

# instal Auto Limit Script Multi Login
cd
wget https://www.tmoe.shop/vpsdebian/config/auto-limit-script.sh
mv ./auto-limit-script.sh /usr/local/bin/auto-limit-script.sh
chmod +x /usr/local/bin/auto-limit-script.sh

# instal Melihat detail user SSH & OpenVPN 
cd
wget https://www.tmoe.shop/vpsdebian/config/userdetail.sh
mv ./userdetail.sh /usr/bin/userdetail.sh
chmod +x /usr/bin/userdetail.sh

# instal Delete Akun Expire
cd
wget https://www.tmoe.shop/vpsdebian/config/deleteuserexpire.sh
mv ./deleteuserexpire.sh /usr/bin/deleteuserexpire.sh
chmod +x /usr/bin/deleteuserexpire.sh

# instal  Kill Multi Login
cd
wget https://www.tmoe.shop/vpsdebian/config/userlimitssh.sh
mv ./userlimitssh.sh /usr/bin/userlimitssh.sh
chmod +x /usr/bin/userlimitssh.sh

# instal  Kill Multi Login2
cd
wget https://www.tmoe.shop/vpsdebian/config/userlimit.sh
mv ./userlimit.sh /usr/bin/userlimit.sh
chmod +x /usr/bin/userlimit.sh

# instal Auto Banned Akun
cd
wget https://www.tmoe.shop/vpsdebian/config/userban.sh
mv ./userban.sh /usr/local/bin/userban.sh
chmod +x /usr/local/bin/userban.sh

# instal Unbanned Akun
cd
wget https://www.tmoe.shop/vpsdebian/config/userunban.sh
mv ./userunban.sh /usr/bin/userunban.sh
chmod +x /usr/bin/userunban.sh

# instal Mengunci Akun SSH & OpenVPN
cd
wget https://www.tmoe.shop/vpsdebian/config/userlock.sh
mv ./userlock.sh /usr/bin/userlock.sh
chmod +x /usr/bin/userlock.sh

# instal Membuka user SSH & OpenVPN yang terkunci
cd
wget https://www.tmoe.shop/vpsdebian/config/userunlock.sh
mv ./userunlock.sh /usr/bin/userunlock.sh
chmod +x /usr/bin/userunlock.sh

# instal Melihat daftar user yang terkick oleh perintah user-limit
cd
wget https://www.tmoe.shop/vpsdebian/config/loglimit.sh
mv ./loglimit.sh /usr/bin/loglimit.sh
chmod +x /usr/bin/loglimit.sh

# instal Melihat daftar user yang terbanned oleh perintah user-ban
cd
wget https://www.tmoe.shop/vpsdebian/config/logban.sh
mv ./logban.sh /usr/bin/logban.sh
chmod +x /usr/bin/logban.sh

# instal Set Auto Reboot
cd
wget https://www.tmoe.shop/vpsdebian/config/autoreboot.sh
mv ./autoreboot.sh /usr/bin/autoreboot.sh
chmod +x /usr/bin/autoreboot.sh

# Install SPEED tES
cd
apt-get install python
wget https://www.tmoe.shop/vpsdebian/config/speedtest.py.sh
mv ./speedtest.py.sh /usr/bin/speedtest.py.sh
chmod +x /usr/bin/speedtest.py.sh

# instal userdelete
cd
wget https://www.tmoe.shop/vpsdebian/config/userdelete.sh
mv ./userdelete.sh /usr/bin/userdelete.sh
chmod +x /usr/bin/userdelete.sh

# instal diagnosa
cd
wget https://www.tmoe.shop/vpsdebian/config/diagnosa.sh
mv ./diagnosa.sh /usr/bin/diagnosa.sh
chmod +x /usr/bin/diagnosa.sh

# instal ram
cd
wget https://www.tmoe.shop/vpsdebian/config/ram.sh
mv ./ram.sh /usr/bin/ram.sh
chmod +x /usr/bin/ram.sh

# log install
cd
wget https://www.tmoe.shop/vpsdebian/config/log-install.sh
mv ./log-install.sh /usr/bin/log-install.sh
chmod +x /usr/bin/log-install.sh

# edit ubah-port
cd
wget https://www.tmoe.shop/vpsdebian/config/ubahport.sh
mv ./ubahport.sh /usr/bin/ubahport.sh
chmod +x /usr/bin/ubahport.sh

# edit-port-dropbear
cd
wget https://www.tmoe.shop/vpsdebian/config/edit-port-dropbear.sh
mv ./edit-port-dropbear.sh /usr/bin/edit-port-dropbear.sh
chmod +x /usr/bin/edit-port-dropbear.sh

# edit-port-openssh
cd
wget https://www.tmoe.shop/vpsdebian/config/edit-port-openssh.sh
mv ./edit-port-openssh.sh /usr/bin/edit-port-openssh.sh
chmod +x /usr/bin/edit-port-openssh.sh

# edit-port-openvpn
cd
wget https://www.tmoe.shop/vpsdebian/config/edit-port-openvpn.sh
mv ./edit-port-openvpn.sh /usr/bin/edit-port-openvpn.sh
chmod +x /usr/bin/edit-port-openvpn.sh

# edit-port-squid
cd
wget https://www.tmoe.shop/vpsdebian/config/edit-port-squid.sh
mv ./edit-port-squid.sh /usr/bin/edit-port-squid.sh
chmod +x /usr/bin/edit-port-squid.sh

# edit-port-stunnel
cd
wget https://www.tmoe.shop/vpsdebian/config/edit-port-stunnel.sh
mv ./edit-port-stunnel.sh /usr/bin/edit-port-stunnel.sh
chmod +x /usr/bin/edit-port-stunnel.sh

# restart
cd
wget https://www.tmoe.shop/vpsdebian/config/restart.sh
mv ./restart.sh /usr/bin/restart.sh
chmod +x /usr/bin/restart.sh

# restart-dropbear
cd
wget https://www.tmoe.shop/vpsdebian/config/restart-dropbear.sh
mv ./restart-dropbear.sh /usr/bin/restart-dropbear.sh
chmod +x /usr/bin/restart-dropbear.sh

# restart-squid
cd
wget https://www.tmoe.shop/vpsdebian/config/restart-squid.sh
mv ./restart-squid.sh /usr/bin/restart-squid.sh
chmod +x /usr/bin/restart-squid.sh

# restart-openvpn
cd
wget https://www.tmoe.shop/vpsdebian/config/restart-openvpn.sh
mv ./restart-openvpn.sh /usr/bin/restart-openvpn.sh
chmod +x /usr/bin/restart-openvpn.sh

# restart-webmin
cd
wget https://www.tmoe.shop/vpsdebian/config/restart-webmin.sh
mv ./restart-webmin.sh /usr/bin/restart-webmin.sh
chmod +x /usr/bin/restart-webmin.sh

# restart-stunnel
cd
wget https://www.tmoe.shop/vpsdebian/config/restart-stunnel.sh
mv ./restart-stunnel.sh /usr/bin/restart-stunnel.sh
chmod +x /usr/bin/restart-stunnel.sh

# disable-user-expire
cd
wget https://www.tmoe.shop/vpsdebian/config/disable-user-expire.sh
mv ./disable-user-expire.sh /usr/bin/disable-user-expire.sh
chmod +x /usr/bin/disable-user-expire.sh

# bannerssh
wget https://www.tmoe.shop/vpsdebian/config/bannerssh
mv ./bannerssh /bannerssh
chmod 0644 /bannerssh

# Install Menu
cd
wget https://www.tmoe.shop/vpsdebian/menu
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# download script
cd
wget -O /etc/bannerssh "https://www.tmoe.shop/vpsdebian/config/bannerssh"
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "* * * * *  root /usr/local/bin/userban.sh" > /etc/cron.d/userban

#Install Figlet
cd
apt-get -y install figlet
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

#bonus block playstation
cd
iptables -A OUTPUT -d account.sonyentertainmentnetwork.com -j DROP
iptables -A OUTPUT -d auth.np.ac.playstation.net -j DROP
iptables -A OUTPUT -d auth.api.sonyentertainmentnetwork.com -j DROP
iptables -A OUTPUT -d auth.api.np.ac.playstation.net -j DROP
iptables-save

#bonus block torrent
cd
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

# Restart Service
cd
chown -R www-data:www-data /home/vps/public_html
service cron restart
service openvpn restart
service ssh restart
service dropbear restart
service squid3 restart
service webmin restart
/etc/init.d/stunnel4 restart

cd
rm -f /root/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo "Setup by NS-SSH"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$MYIP:81/client.ovpn)"  | tee -a log-install.txt
echo "SSL  : 443"  | tee -a log-install.txt
echo "Dropbear : 3128"  | tee -a log-install.txt
echo "Squid3   : 80, 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo "badvpn   : badvpn-udpgw port 7300"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------"  | tee -a log-install.txt
echo "Webmin   : http://$MYIP:10000/"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "VPS REBOOT TIAP JAM 00.00 !"  | tee -a log-install.txt
echo""  | tee -a log-install.txt
echo "Please Reboot your VPS !"  | tee -a log-install.txt
echo "================================================"  | tee -a log-install.txt
cd ~/
rm -f /root/ubuntu14.04.sh
rm -f /root/speedtest.py.sh
rm -rf /root/ddos-deflate-master.zip
