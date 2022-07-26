#!/bin/bash 

git clone https://github.com/quincycheng/killercoda-env-conjur-jwt-k8s.git  && \
mv killercoda-env-conjur-jwt-k8s/* . && \
rm -rf killercoda-env-conjur-jwt-k8s/

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash &

apt install -y wamerican && apt install -y python3-pip && pip3 install conjur 

