#!/bin/bash
if [ ! command -v apt >/dev/null 2>&1 ]; then
   echo "没有apt，请安装！"
   exit 3
fi

sudo apt update
sudo apt install -y squid

command -v wget > /dev/null 2>&1 || sudo apt install -y wget

if [ ! -e "./squid.conf" ]; then
#   cat> ./squid.conf<<EOF
#      http_access allow all
#EOF
    wget https://raw.githubusercontent.com/snoopies/myscripts/refs/heads/main/squid.conf
fi
sudo mv ./squid.conf /etc/squid/
sudo systemctl restart squid

