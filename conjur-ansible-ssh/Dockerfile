FROM alpine:3.16
LABEL maintainer="Quincy Cheng (quincy.cheng@cyberark.com)"

RUN apk add --no-cache \ 
        openssh python3 \
    && ssh-keygen -A \
    && mkdir /root/.ssh \
    && chmod 0700 /root/.ssh \
    && echo "root:$(openssl rand 96 | openssl enc -A -base64)" | chpasswd 
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
 
RUN adduser -D service01
RUN adduser -D service02
RUN echo -n 'service01:W/4m=cS6QSZSc*nd' | chpasswd
RUN echo -n 'service02:5;LF+J4Rfqds:DZ8' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]

