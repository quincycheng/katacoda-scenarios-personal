printf "✅\n- Starting a fresh Jenkins installation..." && \
timeout 30s bash -c 'while [ "$(docker ps -a|grep jenkins)" = "" ];do printf ".";sleep 2s;done'   && \
echo -e "✅\n- Ready! 😀"