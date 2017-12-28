sed -i 's/* hard nproc 1//g' /etc/security/limits.conf
sed -i '$ i\* hard nproc 2' /etc/security/limits.conf
service ssh restart
