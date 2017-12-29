#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Server telah berhasil direboot pada tanggal $tanggal pukul $waktu." >> /root/user-expired.txt
cd /usr/bin/
./user-expired.sh
