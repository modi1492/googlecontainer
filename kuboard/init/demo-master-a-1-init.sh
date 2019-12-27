hostnamectl set-hostname demo-master-a-1
hostnamectl status
echo "127.0.0.1   $(hostname)" >> /etc/hosts
