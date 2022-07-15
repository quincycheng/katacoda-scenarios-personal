#!/bin/bash 
git clone https://github.com/quincycheng/katacoda-secretless-files.git > /dev/null 2>&1 && \
cd katacoda-secretless-files/ && \
apt install -y wamerican && \
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
clear