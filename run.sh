#!/bin/bash

set -euo pipefail

IFS= read -r password < passwd.txt
IFS= read -r url < url.txt

echo '############################'
echo $'Password:\t'"${password}"
echo $'SS URL:\t\t'"${url}"
echo 'Also QR code with server credentials is available in this REPL files.'
echo '############################'

uname -a
curl -o hola-proxy -L https://github.com/Snawoot/hola-proxy/releases/download/v1.5.4/hola-proxy.linux-amd64
chmod +x ./hola-proxy
nohup ./hola-proxy -country jp > /dev/null 2>&1 &

Environment="HTTP_PROXY=http://127.0.0.1:8080"
Environment="HTTPS_PROXY=http://127.0.0.1:8080"
Environment="NO_PROXY=*.local,local,localhost,127.0.0.0/8,10.0.0.0/8,172.16.0.0/16,172.20.0.0/16,192.168.0.0/16"
go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:'"${password}"'@:8488' -verbose -plugin v2ray-plugin -plugin-opts "server" -udp=false
