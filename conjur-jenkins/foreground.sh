#!/bin/bash
set +H

date

clear && printf "Preparing environment...\n- docker-compose.yml..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/docker-compose.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Downloading Jenkins files..." && \
timeout 120s bash -c 'while ! [ -f /root/jenkins_home/config.xml ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Python PIP..." && \
timeout 60s bash -c 'while [ ! $(command -v pip) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Conjur CLI..." && \
timeout 60s bash -c 'while [ ! $(command -v conjur) ];do printf ".";sleep 2s;done'   && \

printf "✅\n- Setting up target web application..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep http-auth-server)" = "" ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Setting up Jenkins..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep jenkins)" = "" ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Setting up Conjur..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep conjur_server)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"

date