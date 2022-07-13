
### Install CLI

Let's install Conjur CLI by executing the following command.   It will take a while.
```
apt install software-properties-common jq -y && \
add-apt-repository -y ppa:deadsnakes/ppa && \
apt install -y python3.10 python3.10-distutils && \
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 && \
python3.10 -m pip install conjur==7.1.0
```{{execute}}

To check the version installed, execute:
`conjur --version`{{execute}}


### Conjur Init

You only to initialize Conjur CLI once.

```
conjur init  -a demo-u {{TRAFFIC_HOST1_8080}} 
```{{execute}}

If `Trust this certificate? yes/no (Default: no):` is prompted, answer:
 `yes`{{execute}}

If the above command returns an error message, that means the system is being started.
Please wait for a moment and try again.


### Login to Conjur

Let's login to Conjur
```
conjur login -i admin -p "$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"
```{{execute}}

Please note that in this tutorial, we have saved `api_key` in `admin.out` file and as `api_key` environment variable.
In production, please keep the `api_key` in a safe location
