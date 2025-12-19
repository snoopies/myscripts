#!/bin/bash
if [[ -z "$network_secret" ]]; then
  echo "Please set 'network_secret'"  
exit 2
fi

#command -v unzip > /dev/null 2>&1 || sudo apt install -y unzip
if [ ! command -v unzip >/dev/null 2>&1 ]; then
   sudo apt install -y unzip
fi

if [ ! -e "./easytier-linux-x86_64-v2.2.4.zip ]; then
   wget 
fi

unzip -qo easytier-linux-x86_64-v2.2.4.zip
cd easytier-linux-x86_64

#nohup sudo ./easytier-core  --network-name default  --network-secret "$network_secret" -p wss://claw.now.cc:443 -i 10.1.1.100/24 --no-tun &
sudo mkdir -p /etc/et

MY_DIR=$(pwd)

cat>./config.toml <<EOF
hostname = "my-vm"
ipv4 = "10.1.1.100"
dhcp = false
listeners = []
mapped_listeners = []
exit_nodes = []
rpc_portal = "0.0.0.0:15888"

[network_identity]
network_name = "default"
network_secret = "$network_secret"

[[peer]]
uri = "wss://claw.now.cc:443"

[flags]
EOF

cat>./easytier.service <<EOF
[Unit]
Description=EasyTier
After=network.target

[Service]
Type=simple
WorkingDirectory=$MY_DIR
# ExecStart=/usr/bin/easytier-core -i 192.168.66.80 --network-name ysicing --network-secret ysicing -e tcp://public.easytier.transform: translateY(11010 --dev-name easytier0 --rpc-portal 127.0.0.1:15888 --no-listener
#ExecStart=$MY_DIR/easytier-core  --network-name default  --network-secret $network_secret -p wss://claw.now.cc:443 -i 10.1.1.100/24 --no-tun
ExecStart=$MY_DIR/easytier-core -c /etc/et/config.toml
Restart=always
RestartSec=10
User=root
Group=root
[Install]
WantedBy=multi-user.target
EOF

sudo mv ./config.toml /etc/et/
sudo mv ./easytier.service /etc/systemd/system/
sudo systemctl enable easytier --now
#systemctl daemon-reload
#systemctl restart easytier
