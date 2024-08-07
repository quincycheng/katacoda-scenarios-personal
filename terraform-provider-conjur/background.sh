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
    restart: on-failure
EOF

cat <<'EOF' > .env
CONJUR_ADMIN=b81t11ebd2en115rjc3bbyfhhhtvcttyc0bm42jcagzreb8pd7
CONJUR_DATA_KEY=B/gTTlJH1mGU3rcYwp+ShzhuGK5kV6JEatXLw51MHc8=
EOF

#################
#  SSL

echo '172.30.1.2 proxy' >> /etc/hosts


mkdir -p conf
mkdir -p conf/tls

cat <<'EOF' > conf/tls/nginx.crt
-----BEGIN CERTIFICATE-----
MIIDcjCCAlqgAwIBAgIJAJ5mUhk7uqDiMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNV
BAYTAlVTMRIwEAYDVQQIDAlXaXNjb25zaW4xEDAOBgNVBAcMB01hZGlzb24xETAP
BgNVBAoMCEN5YmVyQXJrMQ0wCwYDVQQLDARPbnl4MQ4wDAYDVQQDDAVwcm94eTAe
Fw0yMjA3MTkwMjM3NDJaFw0zMjA3MTYwMjM3NDJaMGUxCzAJBgNVBAYTAlVTMRIw
EAYDVQQIDAlXaXNjb25zaW4xEDAOBgNVBAcMB01hZGlzb24xETAPBgNVBAoMCEN5
YmVyQXJrMQ0wCwYDVQQLDARPbnl4MQ4wDAYDVQQDDAVwcm94eTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAPRWNO9TXWGOKCmCottrxgxrq1bFwDrwdekK
TAT41ZL5OsZS97uFkRQoC6i1NFl6Y7jKD3nUHfd5+i4C8Q8pmi/9KOZGDzOeOHEf
KRWGxe0wfL+wEcKaSNSLSjqlETvo42x5JXlIxNtwk6ZmwpfkpW9d93D7XjmI7baH
WyXqbPmdub7A9guwWHb0ahotQMdGsPzJk28+P566/NTPEgiTtZUk8TZE1R6FCGT5
8B9xFUJtnQuMz+dPYhPVvQATt/NVst1MUIb7i8a4/oUFcgeoBevGweFDhXKal5v/
CokyvJpzpihj4eZhUJag31Gteruams0RVkkEDNqb7DmA/P9r/B8CAwEAAaMlMCMw
IQYDVR0RBBowGIIJbG9jYWxob3N0ggVwcm94eYcEfwAAATANBgkqhkiG9w0BAQsF
AAOCAQEANlueCzqj4iscv4d7tfXk9HAEYGwKcEMqxUGgbHCHXDqBO8VRRXl2u9n1
Cc7wkPWlAf2S/C+EnRn29GdnPArRgjRthRefuEW6Jrrkym2wYbunfw819TE+COjD
yuMq76WYIRXN+5ohJ8iXgbyqVgvfsJMfhKQSzsaN4L80qptxw5OwuNUBDtKkXABa
2CRR6bxll9Yk3KXL+goLlkShjTDUpaIEzkmA4E40nPf0YJ4vmsusQ3NpP66Bdmey
1a51CZ1B7Vnjo88FR1B8E/9QYXClc7Wv7m+1ApStDIqNF77BGVeM/HqhyLJBWKbW
uif5gFBtTXe9eUCfiymm+tPlrBkmuw==
-----END CERTIFICATE-----
EOF

cat <<'EOF' > conf/tls/nginx.key
-----BEGIN PRIVATE KEY-----
MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQD0VjTvU11hjigp
gqLba8YMa6tWxcA68HXpCkwE+NWS+TrGUve7hZEUKAuotTRZemO4yg951B33efou
AvEPKZov/SjmRg8znjhxHykVhsXtMHy/sBHCmkjUi0o6pRE76ONseSV5SMTbcJOm
ZsKX5KVvXfdw+145iO22h1sl6mz5nbm+wPYLsFh29GoaLUDHRrD8yZNvPj+euvzU
zxIIk7WVJPE2RNUehQhk+fAfcRVCbZ0LjM/nT2IT1b0AE7fzVbLdTFCG+4vGuP6F
BXIHqAXrxsHhQ4Vympeb/wqJMryac6YoY+HmYVCWoN9RrXq7mprNEVZJBAzam+w5
gPz/a/wfAgMBAAECggEAFxAUCwsJY23xqIlmKePwW7fGAnjD/kw4NPj91/JM5oST
4ahvLcobuZVWFGSWPmPpCcY4070L3xIqZTFt44p/vUveEm5GfQ7QMQ1J6XhBMnRD
MizCYGYDvdwv830lNUx0OwbsXJhbzILBzREiCQhR/UMXWhi/+hpMpc/88IVCKAVm
CxwPOYcpmLns5UPjnqcMJdR5+9WjNY5eiBSdt69kOdxxrb7/8rDoE88P7xnH4aOO
qdXt/02wJHyhi2cWfrsLvWXfwbIlowW+9oTXU7iFQDlSbkyM9pNiJuugjRV7s5jS
PStMlkRPJ9Vma24224P77S5IBvsjqCcHC53FkEHewQKBgQD0nwBjCTRC1Ac4GmDc
4KaMGXy3FDpKTsMM2lGFzpR0voiFQl2MUjPN6F3rHI8uoTxaYih9AMDUpNwbHvYe
wjtV1PV2v4fcMz1LtqGG8VeTTdGviIZlJinoHD6e5jf+MmzMUi0j+SZMU0dk/hXn
4Amef4HPShHm1LyqTmbldjJkkQKBgQD/s9GxfDhAWV2xKeUEsh+SryF/j2xI8OLT
/AP4eVnjLSh7wOP8f84ClsyykWuArx7fnTNVFZTy0QXMQUPsi9XP+nNGY06iM78n
lIs9QIgxXYpbcjDIb4Tu+BrTEQ8SdBbU9DHeY7dwrsJARakw9HHOJzsN7//cjf8S
zAfAYW/trwKBgQDBlP6CYStJY29fF4jl4qYKIrVOUKScX1390ttGz6cuCAYTpuRP
AlJatXN1dsFcfl47jIhL/Aedf+VrVQIib0TzdLbXxVRnjukH/LwxBNZwDNpOVfU9
IIlzVL69kqRm9lKhErsER8vmBNVv958wQ1x5YKBCgXRPPrUa9TZ6iiHw8QKBgQCO
1ONNQRYq28B6Ney3ssfwJ+OOXY8fL2+E+kE9iourWo5CknzHjpyE1beCB7kFKM0W
G7mQzX1mJVwXvF00xOeqRTwfFVnXQRCGC3O7w1BQQvAGJMMbMzAOTIivXdgNdstK
KR2yHAFb8EKRpFfeAK2ReliCcI17pdXVqiKqU8MyAQKBgQCST6B99UwMrImgWk4a
1p/SEsj2Ak0mKaPZ84D9gECoBcSjPc+4cSL4+U5uRvaE4OS2oyskkUB4tGTSw4zq
L3uxLXlSM4DLM6N/lMDLWToHGDzLiidi551ntz8kwroGfprYVoeuljdfuCf2Xr2Q
qBZ6hbQYgA+AeoYXYx2klPniIg==
-----END PRIVATE KEY-----
EOF

# p12
# openssl pkcs12 -inkey conjur.key -in conjur.pem -export -out conjur.p12

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

cp conf/tls/nginx.crt /etc/conjur.pem

#################
#  Conjur Policy


mkdir -p policy

cat > policy/root.yml << EOF
- !policy
  id: terraform

- !policy
  id: postgres
EOF


cat <<'EOF' > policy/terraform.yml
- !layer

- !host frontend-01

- !grant
  role: !layer
  member: !host frontend-01
EOF

cat <<'EOF' > policy/postgres.yml
- &variables
  - !variable admin-password

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

- !layer

- !host client-01

- !grant
  role: !layer
  member: !host client-01

# Entitlements

- !grant
  role: !group secrets-users
  member: !layer /terraform

- !grant
  role: !group secrets-users
  member: !layer
EOF

cat <<'EOF' > secrets.yml
PGPASSWORD: !var postgres/admin-password
EOF

#################
#  Terraform


cat <<'EOF' > conjur.tf
terraform {
 required_providers {
   conjur = {
     source = "cyberark/conjur"
     version = "0.6.8"
   }
   docker = {
     source  = "kreuzwerker/docker"
     version = "2.11.0"
   }
 }
}

provider "conjur" {
  appliance_url = "https://proxy:8443"
  account = "default"
}
EOF



cat <<'EOF' > docker.tf
resource "docker_network" "demo" {
  name = "demo"
}
EOF


cat <<'EOF' > postgres.tf
data "conjur_secret" "admin-password" {
   name = "postgres/admin-password"
}

resource "docker_image" "postgres" {
  name = "postgres:9.3"
}

resource "docker_container" "postgres" {
  name = "postgres"
  image = "${docker_image.postgres.latest}"
  env = ["POSTGRES_PASSWORD=${data.conjur_secret.admin-password.value}"]
  networks_advanced  {
    name="${docker_network.demo.name}" 
  }
  ports {
    internal = 5432
    external = 5432
  }
}
EOF

docker-compose pull conjur &
docker-compose pull database &

docker pull postgres:9.3 &

#apt update -y &&
apt install -y jq postgresql-client &

#wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py && python3 -m pip install conjur &

wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py &
apt install -y jq &

echo "Installing Conjur CLI..."
wget https://github.com/cyberark/conjur-cli-go/releases/download/v8.0.10/conjur-cli-go_8.0.10_amd64.deb && \
apt -o DPkg::Lock::Timeout=60 install ./conjur-cli-go_8.0.10_amd64.deb & 


wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip && \
unzip terraform_1.5.0_linux_amd64.zip && \
mv terraform /usr/local/bin/ &

docker-compose up -d

echo '172.30.1.2 proxy' >> /etc/hosts
