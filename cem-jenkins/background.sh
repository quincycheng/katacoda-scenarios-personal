#!/bin/bash

docker pull jenkins/jenkins:lts &

git clone https://github.com/quincycheng/killercoda-env-cem-jenkins.git && \
touch .clone_completed && \
cd /root/killercoda-env-cem-jenkins && \
docker-compose up -d
