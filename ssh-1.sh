sed -i 's/* hard nproc 2//g' /etc/security/limits.conf
sed -i '$ i\* hard nproc 1' /etc/security/limits.conf
service ssh restart
