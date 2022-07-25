#!/bin/bash
set +H

clear && \
printf "Preparing environment, it will take 2-5mins...\n- Getting Jenkins files..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/.clone_completed  ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Getting Jenkins Image..." && \
timeout 30s bash -c 'while [ "$(docker image ls | grep jenkins/jenkins)" = "" ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Setting up Jenkins..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep jenkins)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"