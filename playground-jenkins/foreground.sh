clear && \
printf "Preparing environment, it will take 2-5mins...\n" && \
printf "✅\n- Starting a fresh Jenkins installation..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep jenkins)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"