
Let's initialize Conjur CLI.   
You only need to do it once.

```
conjur init -u {{TRAFFIC_HOST1_8080}} -a demo 
```{{execute}}

If `Trust this certificate? yes/no (Default: no):` is prompted, answer `yes`{{execute}}

If the above command returns an error message, that means the system is being started.
Please wait for a moment and try again.


### Login to Conjur

Let's login to Conjur
```
conjur login -i admin -p "$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
```{{execute}}

Please note that in this tutorial, we have saved `api_key` in `admin.out` file and as `api_key` environment variable.
In production, please keep the `api_key` in a safe location
