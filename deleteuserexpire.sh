#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Server telah berhasil direboot pada tanggal $tanggal pukul $waktu." >> /root/deleteuserexpire.txt
cd /usr/bin/
./deleteuserexpire.sh
