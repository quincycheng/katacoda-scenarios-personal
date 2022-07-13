FROM alpine:3.16
LABEL maintainer="Quincy Cheng (quincy.cheng@cyberark.com)"

RUN apk add --no-cache \ 
        openssh \
    && ssh-keygen -A \
    && mkdir /root/.ssh \
    && chmod 0700 /root/.ssh \
    && echo "root:$(openssl rand 96 | openssl enc -A -base64)" | chpasswd 
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
 
RUN adduser --home /tmp -s /bin/sh -D service01
RUN adduser --home /tmp -s /bin/sh -D service02
RUN echo -n 'service01:Wx4m=cS6QSZScZnd' | chpasswd
RUN echo -n 'service02:5xLFoJ4RfqdsxDZ8' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]

