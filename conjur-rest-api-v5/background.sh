#!/bin/bash

cat <<'EOF' > showSettings.sh
#!/bin/bash
refresh_token=$(curl -s --user admin:$conjur_admin ${conjur_url}/authn/default/login)
response=$(curl -s -X POST ${conjur_url}/authn/default/admin/authenticate -d ${refresh_token})
export access_token=$(echo -n $response | base64 | tr -d '\r\n')

c0="\e[39m"
c1="\e[32m"
c2="\e[96m"

echo -e "${c1}Conjur URL: ${c2}"$conjur_url
echo -e "${c1}Conjur Org: ${c2}default"
echo -e "${c1}Conjur User Name: ${c2}admin"
echo -e "${c1}Conjur Password: ${c2}"$conjur_admin
echo -e "${c1}Conjur API Key: ${c2}"$refresh_token
echo -e "${c1}Conjur Access Token: ${c2}"$access_token
echo -e "${c0}"
EOF

chmod +x *.sh

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

apt install -y jq & 

docker-compose pull &