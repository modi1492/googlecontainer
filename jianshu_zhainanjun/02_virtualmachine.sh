wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

systemctl stop firewalld & systemctl disable firewalld
sed -i '/ swap / s/^/#/' /etc/fstab

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum makecache
yum install docker-ce -y
systemctl start docker & systemctl enable docker


