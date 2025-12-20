#!/bin/bash

if [[ -z "$my_cf_token" ]]; then
  echo "Please set 'my_cf_token'!"
  exit 3
fi

## Add cloudflare gpg key
#sudo mkdir -p --mode=0755 /usr/share/keyrings
#curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

## Add this repo to your apt repositories
#echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

## install cloudflared
#sudo apt-get update && sudo apt-get install cloudflared

command -v wget > /dev/null 2>&1 || sudo apt install -y wget
command -v unzip > /dev/null 2>&1 || sudo apt install -y unzip
if [ ! -e "./cloudflared-linux-amd64.zip" ]; then
   wget https://raw.githubusercontent.com/snoopies/myscripts/refs/heads/main/cloudflared-linux-amd64.zip
fi

unzip -qo cloudflared-linux-amd64.zip

read -p "1.后台运行，2.作为服务运行，请输入选择 (1/2): " MODE_CHOICE

if [ "$MODE_CHOICE" = "1" ]; then
   #run the tunnel manually in your current terminal session only:
   nohup cloudflared-linux-amd64 tunnel run --token "$my_cf_token" &
   exit 0  
fi
#install a service to automatically run your tunnel whenever your machine starts:
sudo cloudflared-linux-amd64 service install "$my_cf_token"
