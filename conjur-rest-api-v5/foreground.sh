#!/bin/bash
clear && printf "Verifying environment...\n- Preparing docker-compose files..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/docker-compose.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Preparing scripts..." && \
timeout 30s bash -c 'while ! [ -f /root/showSettings.sh ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing jq..." && \
timeout 60s bash -c 'while [ ! $(command -v jq) ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"


