#!/bin/bash
set +H
clear && printf "Verifying environment...\n- Ansible Playbook..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/insecure-playbook/insecure-playbook.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Target Host 1..." && \
timeout 60s bash -c 'while [ "$(docker ps -a|grep sshd1)" = "" ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Target Host 2..." && \
timeout 60s bash -c 'while [ "$(docker ps -a|grep sshd2)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"
