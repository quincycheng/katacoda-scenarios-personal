#!/bin/bash
set +H
clear && printf "Verifying environment...\n- Preparing App files..." && \
sleep 1s && \
timeout 30s bash -c 'while ! [ -f /root/db/db.yml ];do printf ".";sleep 2s;done'  && \
printf "✅\n- Installing Dictionary..." && \
timeout 60s bash -c 'while ! [ -f /usr/share/dict/american-english ];do printf ".";sleep 2s;done'   && \
printf "✅\n- Target Host 2..." && \
timeout 60s bash -c 'while [ ! $(command -v helm) ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"


