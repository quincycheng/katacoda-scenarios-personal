
Next, we need to create an application identity for Conjur based on API key

The following steps create Conjur policy that defines the Jenkins host and adds that host to a layer.

1. Review the `root` policy by executing:
```
cat root.yml
```{{execute}}

The `root` policy contains 2 policies, `jenkins-frontend` as jenkins application identity and `jenkins-app` as the target web application

```
- !policy
  id: jenkins-frontend

- !policy
  id: jenkins-app
```

2. Load the policy into Conjur under root: 

`conjur policy load -b root -f conjur.yml`{{execute}}

3. Review the `root` policy by executing:
```
cat jenkins-app.yml
```{{execute}}

It declares the layer and Jenkins host.

```
# Declare the secrets which are used to access the database
- &variables
  - !variable web_password

# Define a group which will be able to fetch the secrets
- !group secrets-users

- !permit
  resource: *variables
  # "read" privilege allows the client to read metadata.
  # "execute" privilege allows the client to read the secret data.
  # These are normally granted together, but they are distinct
  #   just like read and execute bits on a filesystem.
  privileges: [ read, execute ]
  roles: !group secrets-users
```

This policy does the following: 

- Declares a layer that inherits the name of the policy under which it is loaded. In our example, the layer name will become jenkins-frontend.
- Declares a host named frontend-01
- Adds the host into the layer. A layer may have more than one host.
Change the following items:
- Change the host name to match the DNS host name of your Jenkins host. Change it in both the !host statement and the !grant statement.
- Optionally declare additional Jenkins hosts. Add each new host as a member in the !grant statement.

4. Load the policy into Conjur under the Jenkins policy branch you declared previously: 

`conjur policy load -b jenkins-frontend -f jenkins-frontend.yml | tee frontend.out`{{execute}}

As it creates each new host, Conjur returns an API key.
