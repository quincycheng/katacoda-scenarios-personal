#!/bin/bash 

# Git Clone
git clone https://github.com/quincycheng/killercoda-env-conjur-jwt-k8s.git  && \
mv killercoda-env-conjur-jwt-k8s/* . && \
rm -rf killercoda-env-conjur-jwt-k8s/ && \
touch .clone_completed &

# App
cat <<'EOF' > Dockerfile
FROM bash
CMD ["ping", "killercoda.com"]
EOF

cat <<'EOF' > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "storage-driver": "overlay2",
  "registry-mirrors": ["https://mirror.gcr.io","https://docker-mirror.killer.sh"],
  "mtu": 1454,
  "insecure-registries":[ "controlplane:5000" ]
}
EOF


#sed -i '142 i New Line with sed' /etc/containerd/config.toml

sed -i '142 i \        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."controlplane:5000"]' /etc/containerd/config.toml
sed -i '143 i \          endpoint = ["http://controlplane:5000"]' /etc/containerd/config.toml
sed -i '144 i \      ' /etc/containerd/config.toml
sed -i '145 i \      [plugins."io.containerd.grpc.v1.cri".registry.configs]' /etc/containerd/config.toml
sed -i '146 i \        [plugins."io.containerd.grpc.v1.cri".registry.configs."controlplane:5000".tls]' /etc/containerd/config.toml
sed -i '147 i \          insecure_skip_verify = true' /etc/containerd/config.toml



echo '[[registry]]' >> /etc/containers/registries.conf && \
echo 'location="controlplane:5000"' >> /etc/containers/registries.conf && \
echo 'insecure=true' >> /etc/containers/registries.conf  

systemctl restart docker 

docker run -d -p 5000:5000 --restart=always --name registry registry:2 & 
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash &
