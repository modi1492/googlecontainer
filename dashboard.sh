mkdir dashboard-certs

cd dashboard-certs/

#创建命名空间
kubectl create namespace kubernetes-dashboard

# 创建key文件
openssl genrsa -out dashboard.key 2048

#证书请求
openssl req -days 36000 -new -out dashboard.csr -key dashboard.key -subj '/CN=dashboard-cert'

#自签证书
openssl x509 -req -in dashboard.csr -signkey dashboard.key -out dashboard.crt

#创建kubernetes-dashboard-certs对象
kubectl create secret generic kubernetes-dashboard-certs --from-file=dashboard.key --from-file=dashboard.crt -n kubernetes-dashboard

#安装
kubectl create -f  ~/recommended.yaml

#检查结果
kubectl get pods -A  -o wide

kubectl get service -n kubernetes-dashboard  -o wide
cat <<EOF > ~/dashboard-certs/dashboard-admin.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: dashboard-admin
  namespace: kubernetes-dashboard
EOF
kubectl create -f dashboard-admin.yaml

cat <<EOF > ~/dashboard-certs/dashboard-admin-bind-cluster-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dashboard-admin-bind-cluster-role
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: dashboard-admin
  namespace: kubernetes-dashboard
EOF
kubectl create -f dashboard-admin.yaml

kubectl create -f dashboard-admin-bind-cluster-role.yaml

kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep dashboard-admin | awk '{print $1}')





