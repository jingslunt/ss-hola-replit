{ pkgs }: {
    deps = [
        pkgs.pwgen
        pkgs.qrencode.bin
        pkgs.shadowsocks-v2ray-plugin
        pkgs.go-shadowsocks2
        pkgs.curl
        pkgs.gcc
        pkgs.go
        pkgs.git
    ];
}
