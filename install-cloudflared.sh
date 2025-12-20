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



#run the tunnel manually in your current terminal session only:
cloudflared tunnel run --token "$my_cf_token"

#install a service to automatically run your tunnel whenever your machine starts:

sudo cloudflared service install "$my_cf_token"

