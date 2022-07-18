#!/bin/bash
set +H
clear && printf "Preparing environment...\n- docker-compose.yml..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/docker-compose.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Jenkins files..." && \
timeout 120s bash -c 'while ! [ -f /root/jenkins_home/config.xml ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Python PIP..." && \
timeout 60s bash -c 'while [ ! $(command -v pip) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Conjur CLI..." && \
timeout 60s bash -c 'while [ ! $(command -v conjur) ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"
