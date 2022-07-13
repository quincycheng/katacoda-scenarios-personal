#!/bin/bash
sudo service docker restart
curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.conjur2022.yml
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out

apt install -y python3-pip jq
pip3 install conjur

conjur init -u $1 -a demo 
sleep 2
conjur login -i admin -p "$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"

