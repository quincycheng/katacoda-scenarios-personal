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
EOF

cat <<'EOF' > .env
CONJUR_ADMIN=b81t11ebd2en115rjc3bbyfhhhtvcttyc0bm42jcagzreb8pd7
CONJUR_DATA_KEY=B/gTTlJH1mGU3rcYwp+ShzhuGK5kV6JEatXLw51MHc8=
EOF



cat <<EOF > docker-compose-outdated.yml
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

docker-compose pull conjur &
#docker-compose pull client &
docker-compose pull http-authn-server &
docker-compose pull jenkins &

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

