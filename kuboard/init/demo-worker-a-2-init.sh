hostnamectl set-hostname demo-worker-a-2
hostnamectl status
echo "127.0.0.1   $(hostname)" >> /etc/hosts
