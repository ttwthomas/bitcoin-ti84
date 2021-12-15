#!/bin/bash
git clone https://github.com/BlackBip/Ti-Basic-BTC-Miner
cd Ti-Basic-BTC-Miner/source
tibasic -d BTCMINE.8xp 
echo "Pause" >> BTCMINE.tib
tibasic -o BTCMINE.8xp BTCMINE.tib
sed -i "40 c sleep 30" home/ubuntu/.vnc/xstartup
sudo -u ubuntu -H vncserver :1
