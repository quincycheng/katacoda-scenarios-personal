#!/bin/bash

#docker-compose.yml

cat <<'EOF' > docker-compose.yml
version: '3'
services:
  database:
    image: quincycheng/conjur-db:20220717
    container_name: conjur_db
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust
    ports:
      - 8432:5432

  conjur:
    image: quincycheng/conjur-server:20220717
    container_name: conjur_server
    command: server
    environment:
      DATABASE_URL: postgres://postgres@database/postgres
      CONJUR_DATA_KEY: $CONJUR_DATA_KEY
      CONJUR_AUTHENTICATORS:
    depends_on:
    - database
    restart: on-failure
    ports:
      - 8080:80

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

  openssl:
    image: cyberark/conjur
    container_name: openssl
    entrypoint:
     - openssl
     - req
     - -newkey
     - rsa:2048
     - -days
     - "365"
     - -nodes
     - -x509
     - -config
     - /tmp/conf/tls.conf
     - -extensions
     - v3_ca
     - -keyout
     - /tmp/conf/nginx.key
     - -out
     - /tmp/conf/nginx.crt
    volumes:
     - ./conf/tls/:/tmp/conf

  proxy:
    image: nginx:1.13.6-alpine
    container_name: nginx_proxy
    ports:
      - "8443:443"
    volumes:
      - ./conf/:/etc/nginx/conf.d/:ro
      - ./conf/tls/:/etc/nginx/tls/:ro
    depends_on:
    - conjur
    - openssl
    restart: on-failure
EOF

cat <<'EOF' > .env
CONJUR_ADMIN=b81t11ebd2en115rjc3bbyfhhhtvcttyc0bm42jcagzreb8pd7
CONJUR_DATA_KEY=B/gTTlJH1mGU3rcYwp+ShzhuGK5kV6JEatXLw51MHc8=
EOF

mkdir conf
cat <<'EOF' > conf/default.conf
server {
    listen              443 ssl;
    server_name         proxy;
    access_log          /var/log/nginx/access.log;

    ssl_certificate     /etc/nginx/tls/nginx.crt;
    ssl_certificate_key /etc/nginx/tls/nginx.key;

    location / {
      proxy_pass http://conjur;
    }
}
EOF

mkdir conf/tls
cat <<'EOF' > conf/tls/tls.conf
[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn
x509_extensions = v3_ca # The extentions to add to the self signed cert
req_extensions  = v3_req
x509_extensions = usr_cert

[ dn ]
C=US
ST=Wisconsin
L=Madison
O=CyberArk
OU=Onyx
CN=proxy

[ usr_cert ]
basicConstraints=CA:FALSE
nsCertType                      = client, server, email
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
nsComment                       = "OpenSSL Generated Certificate"
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid,issuer

[ v3_req ]
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment

[ v3_ca ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = localhost
DNS.2 = proxy
IP.1 = 127.0.0.1
EOF

docker-compose pull conjur &
docker-compose pull http-authn-server &
docker-compose pull jenkins &
docker-compose pull database &
docker-compose pull proxy &

apt install -y jq python3-pip && pip install conjur & 

# Get jenkins_home
git clone https://github.com/quincycheng/katacoda-env-conjur-jenkins.git && \
mv katacoda-env-conjur-jenkins/jenkins_home . && \
rm -rf katacoda-env-conjur-jenkins

cat > root.yml << EOF
- !policy
  id: jenkins-frontend

- !policy
  id: jenkins-app
EOF

cat > jenkins-app.yml << EOF
# Declare the secrets which are used to access the database
- &variables
  - !variable web_password

# Define a group which will be able to fetch the secrets
- !group secrets-users

- !permit
  resource: *variables
  # "read" privilege allows the client to read metadata.
  # "execute" privilege allows the client to read the secret data.
  # These are normally granted together, but they are distinct
  #   just like read and execute bits on a filesystem.
  privileges: [ read, execute ]
  roles: !group secrets-users
EOF

cat > jenkins-frontend.yml << EOF
- !layer

- !host frontend-01

- !grant
  role: !layer
  member: !host frontend-01
EOF

cat > jenkins-app.entitled.yml << EOF
- &variables
  - !variable web_password

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements

- !grant
  role: !group secrets-users
  member: !layer /jenkins-frontend
EOF

docker-compose up -d

