#!/bin/bash 

git clone https://github.com/quincycheng/katacoda-secretless-files.git > /dev/null 2>&1 && \
mv katacoda-secretless-files/* . && \
rm -rf katacoda-secretless-files/

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash &

apt install -y wamerican &

wget  https://github.com/cyberark/conjur-cli-go/releases/download/v8.0.9/conjur-cli-go_8.0.9_amd64.deb && \
sudo dpkg -i conjur-cli-go_8.0.9_amd64.deb & 
