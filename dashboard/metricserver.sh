cd ~

mkdir metrics-server

cd metrics-server

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/aggregated-metrics-reader.yaml

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/auth-delegator.yaml

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/auth-reader.yaml

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/metrics-apiservice.yaml

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/metrics-server-deployment.yaml

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/metrics-server-service.yaml

wget https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/resource-reader.yaml

metrics-server-deployment.yaml

cat <<EOF > metrics-server-deployment.yaml
spec:
  selector:
    matchLabels:
      k8s-app: metrics-server
  template:
    metadata:
      name: metrics-server
      labels:
        k8s-app: metrics-server
    spec:
      serviceAccountName: metrics-server
      volumes:
      # mount in tmp so we can safely use from-scratch images and/or read-only containers
      - name: tmp-dir
        emptyDir: {}
      containers:
      - name: metrics-server
        image: k8s.gcr.io/metrics-server-amd64:v0.3.6
        imagePullPolicy: IfNotPresent #修改
        command: #增加
        - /metrics-server
        - --kubelet-preferred-address-types=InternalIP
        - --kubelet-insecure-tls
        volumeMounts:
        - name: tmp-dir
          mountPath: /tmp
EOF
kubectl create -f ~/metrics-server
