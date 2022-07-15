#!/bin/bash

wget https://raw.githubusercontent.com/QuincyChengAtWork/katacoda-scenarios/master/conjur-rest-api-v5/assets/showSettings.sh && \
chmod +x *.

curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.conjur2022.yml  

docker-compose pull &

apt install -y python3-pip && pip3 install conjur 