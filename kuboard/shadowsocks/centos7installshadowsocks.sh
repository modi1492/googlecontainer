yum -y install epel-release
yum -y install python-pip
pip install shadowsocks
mkdir /etc/shadowsocks

cat <<EOF > /etc/shadowsocks/shadowsocks.json
{
    "server":"172.96.204.189",
    "server_port":14730,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"cmd&lxddemima",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false,
    "workers": 1
}
EOF

cat <<EOF > /etc/systemd/system/shadowsocks.service
[Unit]
Description=Shadowsocks
[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/sslocal -c /etc/shadowsocks/shadowsocks.json
[Install]
WantedBy=multi-user.target
EOF

systemctl enable shadowsocks.service
systemctl start shadowsocks.service
systemctl status shadowsocks.service

curl --socks5 127.0.0.1:1080 http://httpbin.org/ip



