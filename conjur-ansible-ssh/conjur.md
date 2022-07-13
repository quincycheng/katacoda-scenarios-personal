
To setup Conjur, execute:
```
docker-compose pull
docker-compose run --no-deps --rm conjur data-key generate > data_key
export CONJUR_DATA_KEY="$(< data_key)"
docker-compose up -d 
sleep 10
docker-compose exec conjur conjurctl account create demo | tee admin.out
```{{execute}}

After the command finishes, we can access the web interface:
{{TRAFFIC_HOST1_8080}})

Please wait for a moment if it doesn't display "Your Conjur server is running!"

