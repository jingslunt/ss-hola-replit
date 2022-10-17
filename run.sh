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
if [[ ! -f hola-proxy ]]
then
curl -o hola-proxy -L https://github.com/Snawoot/hola-proxy/releases/download/v1.5.4/hola-proxy.linux-amd64
chmod +x ./hola-proxy
echo "run hola"
fi
ps -ef |grep hola-proxy|grep -v grep >/dev/null || nohup ./hola-proxy -bind-address 127.0.0.1:8888 -country jp > /dev/null 2>&1 &



if [[ ! -f gg ]]
then
curl -o gg -L https://github.com/mzz2017/gg/releases/download/v0.2.13/gg-linux-x86_64
chmod +x gg
fi


./gg  -vv --noudp  --node http://127.0.0.1:8888 go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:'"${password}"'@0.0.0.0:8488' -verbose -plugin v2ray-plugin -plugin-opts "server" -udp=false

sleep 120
