#!/bin/bash
set +H
clear && printf "Preparing environment...\n- docker-compose.yml..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/docker-compose.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Jenkins files..." && \
timeout 120s bash -c 'while ! [ -f /root/jenkins_home/conjur.xml ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"
