#!/bin/bash
set +H
clear && date && printf "Preparing environment, it will take 2-5 mins...\n- Typical (insecure) Ansible Playbook..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/insecure-playbook/insecure-playbook.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Secure Ansible Playbook..." && \
timeout 30s bash -c 'while ! [ -f /root/secure-playbook/secure-playbook.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Target Host 1..." && \
timeout 120s bash -c 'while [ "$(docker ps -a|grep sshd1)" = "" ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Target Host 2..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep sshd2)" = "" ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing jq..." && \
timeout 120s bash -c 'while [ ! $(command -v jq) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Ansible Core..." && \
timeout 60s bash -c 'while [ ! $(command -v ansible) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Conjur CLI..." && \
timeout 180s bash -c 'while [ ! $(command -v conjur) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Downloading Conjur policy files..." && \
timeout 120s bash -c 'while ! [ -f /root/db.yml ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Setting up Conjur..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep conjur_server)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"

date