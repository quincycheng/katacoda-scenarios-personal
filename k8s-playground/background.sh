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

# Dictionary & Conjur
apt install -y wamerican && apt install -y python3-pip && pip3 install conjur &

# Registry, Restart Docker, Helm
docker run -d -p 5000:5000 --restart=always --name registry registry:2 &
echo '172.30.1.2 local-registry' >> /etc/hosts && \
echo '[[registry]]' >> /etc/containers/registries.conf && \
echo 'location="local-registry:5000"' >> /etc/containers/registries.conf && \
echo 'insecure=true' >> /etc/containers/registries.conf  && \
systemctl restart docker && \
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash &
