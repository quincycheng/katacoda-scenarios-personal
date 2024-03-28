
### Web Access

Once ready, you should be able to access various systems on this environment by accessing the following links:

- External: [Conjur (External access to 8080)]({{TRAFFIC_HOST1_8080}})
- Internal: https://proxy:8443

### Conjur CLI

Conjur CLI has been installed for you.
To check the version installed, execute:
```
conjur --version
```{{execute}}


### Conjur Init

You only to initialize Conjur CLI once.

```
conjur init  -a default -u https://proxy:8443 --self-signed
```{{execute}}

If `Trust this certificate? yes/no (Default: no):` is prompted, answer:
 ```
 yes
 ```{{execute}}

If the above command returns an error message, that means the system is being started.
Please wait for a moment and try again.


### Login to Conjur

Let's login to Conjur, and admin password of the pre-configured environment is `b81t11ebd2en115rjc3bbyfhhhtvcttyc0bm42jcagzreb8pd7`
```
conjur login -i admin -p b81t11ebd2en115rjc3bbyfhhhtvcttyc0bm42jcagzreb8pd7
```{{execute}}

If you got an error about `Error: Unable to authenticate with Conjur. Please check your credentials.`, that means the container is still being initalized.   Please wait for a moment and try the above command again.