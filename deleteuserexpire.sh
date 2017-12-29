#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Remove user expire pada $tanggal pukul $waktu." >> /root/deleteuserexpire.txt
cd /usr/bin/
./delete-user-expire.sh
