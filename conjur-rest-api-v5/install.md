
Let's set up the environment

### Client

We will use `curl` as the HTTPS client to communicate with CyberArk Conjur using REST API calls.

To verify, we can display its usage by `curl --help`{{execute}}

### Starting Conjur

We will install a pre-configured Conjur OSS environment as the server.   
`default` account is created and password of `admin` is `3s1jxkt1e859d1atqw152e070dv2c6hysp2c35cxx1vj331g1n69cba`
It will take a few moments.

```
docker-compose up -d
```{{execute}}

If you'd like to learn more about deploying Conjur OSS, please refer to https://www.conjur.org/