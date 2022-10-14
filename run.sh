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
echo "run hola"
nohup ./hola-proxy -country jp > /dev/null 2>&1 &


echo "shadowsocks"
#export HTTPS_PROXY=http://127.0.0.1:8080
#export HTTP_PROXY=http://127.0.0.1:8080
#export NO_PROXY=.hola.org,hola.org,.local,local,localhost,127.0.0.0/8,10.0.0.0/8,172.16.0.0/16,172.20.0.0/16,192.168.0.0/16

curl -o graftcp-0.4.0-1-x86_64.pkg.tar.zst -L https://github.com/hmgle/graftcp/releases/download/v0.4.0/graftcp-0.4.0-1-x86_64.pkg.tar.zst
zstd -d graftcp-0.4.0-1-x86_64.pkg.tar.zst
tar -xvf graftcp-0.4.0-1-x86_64.pkg.tar


usr/bin/mgraftcp  --http_proxy=127.0.0.1:8080 go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:'"${password}"'@:8488' -verbose -plugin v2ray-plugin -plugin-opts "server" -udp=false
