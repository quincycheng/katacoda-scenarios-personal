
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

### Verify

Visit {{TRAFFIC_HOST1_8080}} and you should see Conjur web page once it is ready.
If it doesn't show up, please wait for a moment before proceed

You can also review the log by executing `docker-compose logs`{{execute}} 

We will have using `http://172.30.1.2:8080` for internal access to Conjur

If you'd like to learn more about deploying Conjur OSS, please refer to https://www.conjur.org/