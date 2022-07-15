#!/bin/bash 

git clone https://github.com/quincycheng/katacoda-secretless-files.git > /dev/null 2>&1 && \
mv katacoda-secretless-files/* . && \
rm -rf katacoda-secretless-files/

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash &

apt install -y wamerican && apt install -y python3-pip && pip3 install conjur 

