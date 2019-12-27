setenforce 0

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

yum install -y epel-release.noarch

yum install -y privoxy

yum -y install python-pip

pip install shadowsocks

mkdir /etc/shadowsocks

echo '{

    "server":"172.96.204.189",

    "server_port":14730,

    "local_address": "127.0.0.1",

    "local_port":1080,

    "password":"cmd&lxddemima",

    "timeout":10000,

    "method":"aes-256-cfb",

    "fast_open": false,

    "workers": 1

}' >/etc/shadowsocks/shadowsocks.json







echo '[Unit]

Description=Shadowsocks

[Service]

TimeoutStartSec=0

ExecStart=/usr/bin/sslocal -c /etc/shadowsocks/shadowsocks.json

[Install]

WantedBy=multi-user.target

' > /etc/systemd/system/shadowsocks.service

systemctl start shadowsocks.service

systemctl enable shadowsocks.service

systemctl status shadowsocks.service


curl --socks5 127.0.0.1:1080 http://httpbin.org/ip

echo 'forward-socks5t / 127.0.0.1:1080 .' >> /etc/privoxy/config

echo 'export http_proxy=http://127.0.0.1:8118

export https_proxy=http://127.0.0.1:8118

' > /etc/profile.d/privoxy.sh

source /etc/profile.d/privoxy.sh

systemctl start privoxy

systemctl status privoxy

systemctl enable privoxy

