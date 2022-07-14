
Conjur has been started.
We need to preform the following steps to make sure it's up & running.


## Verify the system is up & running

To verify, visit {{TRAFFIC_HOST1_8080}}

![theimage](https://github.com/quincycheng/katacoda-scenarios/raw/master/conjur-jenkins/media/01-conjur.PNG)

## Creating an account

Now let's setup an account to Conjur.
```
cd ~/katacoda-env-conjur-jenkins/
docker-compose exec conjur conjurctl account create quick-start | tee admin_key
```{{execute}}

If there are errors returned, it is likely that the container is still spinning up. Please repeat this step by running docker-compose command to create the account again.

At the end of the message, an API key for admin should be returned.  
This is the password for the administrator.

```
Prevent data loss: The conjurctl account create command gives you the public key and admin API key for the account you created. Back them up in a safe location.

Please backup the API key for admin for logging in to the system
```

## Initialize Conjur Client 

To initialize conjur client, execute:
```
docker-compose exec client conjur init -u conjur -a quick-start
```{{execute}}

## Logon to Conjur

To login to Conjur,execute:
```
export admin_api_key="$(cat admin_key|awk '/API key for admin/ {print $NF}'|tr '  \n\r' ' '|awk '{$1=$1};1')"
docker-compose exec client conjur authn login -u admin -p $admin_api_key
```{{execute}}

It should display Logged in once you are successfully logged in