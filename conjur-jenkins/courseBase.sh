#!/bin/bash

#docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3'
services:
  database:
    image: postgres:10.16
    container_name: postgres_database
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust
    ports:
      - 8432:5432
  conjur:
    image: cyberark/conjur
    container_name: conjur_server
    command: server
    environment:
      DATABASE_URL: postgres://postgres@database/postgres
      CONJUR_DATA_KEY:
      CONJUR_AUTHENTICATORS:
    depends_on:
    - database
    restart: on-failure
    ports:
      - 8080:80

  client:
    image: conjurinc/cli5
    depends_on: [ conjur ]
    entrypoint: sleep
    command: infinity
    environment:
      CONJUR_APPLIANCE_URL: http://conjur
      CONJUR_ACCOUNT:
      CONJUR_AUTHN_API_KEY:
      CONJUR_AUTHN_LOGIN: admin

  jenkins:
    image: jenkins/jenkins:lts
    privileged: true
    user: root
    ports:
      - 8081:8080
      - 50000:50000
    container_name: jenkins
    volumes:
      - /root/jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/local/bin/docker:/usr/local/bin/docker

  http-authn-server:
    image: quincycheng/killercoda-http-authn-server:latest
    ports:
     - 8082:80
    container_name: http-auth-server
EOF

docker-compose pull database &
docker-compose pull conjur &
docker-compose pull client &
docker-compose pull http-authn-server &

apt install -y jq & 

# Get jenkins_home
git clone https://github.com/quincycheng/katacoda-env-conjur-jenkins.git && \
mv katacoda-env-conjur-jenkins/jenkins_home . && \
rm -rf katacoda-env-conjur-jenkins


