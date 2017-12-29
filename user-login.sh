#
#!/bin/bash
#Script block akaun SSH
#
#
cd
clear
echo "==================================================================="
echo -e "    SENARAI PELANGGAN YANG SEDANG LOGIN     " 
echo "==================================================================="
echo ""
data=( `ps aux | grep -i dropbear | awk '{print $2}'`);
echo "-------------------------------------------------------------------"
echo "Checking Dropbear login";
echo "-------------------------------------------------------------------"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | wc -l`;
	username=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $10}'`;
	IP=`cat /var/log/auth.log | grep -i dropbear | grep -i "Password auth succeeded" | grep "dropbear\[$PID\]" | awk '{print $12}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $username - $IP";
	fi
done

echo "";

data=( `ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}'`);
echo "-------------------------------------------------------------------"
echo "Checking OpenSSH login";
echo "-------------------------------------------------------------------"
for PID in "${data[@]}"
do
	#echo "check $PID";
	NUM=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | wc -l`;
	username=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $9}'`;
	IP=`cat /var/log/auth.log | grep -i sshd | grep -i "Accepted password for" | grep "sshd\[$PID\]" | awk '{print $11}'`;
	if [ $NUM -eq 1 ]; then
		echo "$PID - $username - $IP";
	fi
done
echo "";
echo "-------------------------------------------------------------------"
echo " Kill multilogin dengan cara menaip kill -9 (nombor PID) "
echo "-------------------------------------------------------------------"
echo -e ""
echo "==================================================================="
echo -e ""
