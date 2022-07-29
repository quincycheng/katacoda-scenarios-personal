### Install CLI

Conjur CLI has been installed for you.
To check the version installed, execute:
```
conjur --version
```{{execute}}


### Conjur Init

You only to initialize Conjur CLI once.

```
conjur init  -a default -u {{TRAFFIC_HOST1_8080}} 
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
