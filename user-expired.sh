#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Kill user expired pada $tanggal pukul $waktu." >> /root/user-expired.txt
menu
8

