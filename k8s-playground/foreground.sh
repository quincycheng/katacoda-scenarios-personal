#!/bin/bash
set +H
clear && printf "Verifying environment...\n- Preparing App files..." && \
sleep 1s && \
timeout 120s bash -c 'while ! [ -f /root/.clone_completed ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Installing Dictionary..." && \
timeout 60s bash -c 'while ! [ -f /usr/share/dict/american-english ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Helm..." && \
timeout 60s bash -c 'while [ ! $(command -v helm) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Installing Conjur CLI..." && \
timeout 60s bash -c 'while [ ! $(command -v conjur) ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Setting up local registry..." && \
timeout 120s bash -c 'while [ "$(docker ps -a|grep registry)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"


