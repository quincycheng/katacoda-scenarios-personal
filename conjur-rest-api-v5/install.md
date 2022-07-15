
Let's set up the environment

### Client

We will use `curl` as the HTTPS client to communicate with CyberArk Conjur using REST API calls.

To verify, we can display its usage by `curl --help`{{execute}}

### Starting Conjur

We will install a Conjur OSS environment as the server.   It will take a few moments.

```
docker-compose pull && \
docker-compose run --no-deps --rm conjur data-key generate > data_key && \
export CONJUR_DATA_KEY="$(< data_key)" && \
docker-compose up -d 
```{{execute}}


### Conjur Account 

Now, we can create an account.
The API key for admin will be displayed.   

```
docker-compose exec conjur conjurctl account create demo | tee admin_key 
```{{execute}}

For demo purpose, we will keep it in `conjur_admin` environment variable.   
Please keep it safe.

```
export conjur_admin="$(grep API admin_key | cut -d: -f2 | tr -d ' \r\n')"
```{{execute}}
