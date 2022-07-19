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

EOF

cat <<'EOF' > .env
CONJUR_ADMIN=b81t11ebd2en115rjc3bbyfhhhtvcttyc0bm42jcagzreb8pd7
CONJUR_DATA_KEY=B/gTTlJH1mGU3rcYwp+ShzhuGK5kV6JEatXLw51MHc8=
EOF

cat <<'EOF' > conjur.tf
terraform {
 required_providers {
   conjur = {
     source  = "local/cyberark/conjur"
     version = "0.5.0"
   }
   docker = {
     source  = "kreuzwerker/docker"
     version = "2.11.0"
   }
 }
}

provider "conjur" {
  appliance_url = "http://localhost:8080"
  account = "default"
}
EOF

cat <<'EOF' > conjur.yml
- !policy
  id: postgres
  body:
    - !variable admin-password
EOF

cat <<'EOF' > conjur.yml
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

cat <<'EOF' > conjur.yml
PGPASSWORD: !var postgres/admin-password
EOF

docker-compose pull conjur &
docker-compose pull database &

apt install -y jq python3-pip postgresql-client && pip install conjur & 

wget https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_amd64.zip && \
unzip terraform_1.2.5_linux_amd64.zip && \
mv terraform /usr/local/bin/ &


docker-compose up -d

