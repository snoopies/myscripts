#!/bin/bash
if [[ -z "$network_secret" ]]; then
  echo "Please set 'network_secret'"  
exit 2
fi

command -v wget > /dev/null 2>&1 || sudo apt install -y wget
if [ ! -e "./easytier-linux-x86_64-v2.2.4.zip" ]; then
   wget https://raw.githubusercontent.com/snoopies/myscripts/refs/heads/main/easytier-linux-x86_64-v2.2.4.zip
fi

#command -v unzip > /dev/null 2>&1 || sudo apt install -y unzip
if [ ! command -v unzip >/dev/null 2>&1 ]; then
   sudo apt install -y unzip
fi

unzip -qo easytier-linux-x86_64-v2.2.4.zip
cd easytier-linux-x86_64

read -p "1.后台运行，2.作为服务运行，请输入选择 (1/2): " MODE_CHOICE

if [ "$MODE_CHOICE" = "1" ]; then
   nohup sudo ./easytier-core  --network-name default  --network-secret "$network_secret" -p wss://claw.now.cc:443 -i 10.1.1.100/24 --no-tun &
else
fi

