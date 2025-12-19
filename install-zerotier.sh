#!/bin/bash

if [[ -z "$NETWORK_ID" ]]; then
  echo "Please set 'NETWORK_ID'"
  exit 2
fi

echo "### Install zerotier and join network ###"

curl -s https://install.zerotier.com | sudo bash
sudo zerotier-cli start
sudo zerotier-cli join "$NETWORK_ID"
