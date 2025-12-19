#!/bin/bash

sudo apt update
sudo apt install squid

if [ ! -e "./squid.conf" ]; then
   cat> ./squid.conf<<EOF
      http_access allow all
EOF
fi

sudo cp ./squid.conf /etc/squid/
sudo systemctl restart squid

