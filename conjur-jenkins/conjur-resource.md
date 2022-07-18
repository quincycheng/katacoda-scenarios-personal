
1. Review the jenkins-app policy by executing 

```
cat jenkins-app.yml
```{{execute}}

It declares the variables & related privileges.

```
#Declare the secrets required by the application

- &variables
  - !variable web_password

# Define a group and assign privileges for fetching the secrets

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements that add the Jenkins layer of hosts to the group  

- !grant
  role: !group secrets-users
  member: !layer /jenkins-frontend
```

This policy does the following: 
- Declares the variables to be retrieved by Jenkins.
- Declares the groups that have read & execute privileges on the variables.
- Adds the Jenkins layer to the group. The path name of the layer is relative to root.

Change the variable names, the group name, and the layer name as appropriate.

2. Load the policy into Conjur under the `jenkins-app` policy branch you declared previously: 

```
conjur policy load -b jenkins-app -f jenkins-app.yml
```{{execute}}


### Entitlements

3. To allow Jenkins host to access the secrets, we will update the jenkins-frontend policy accordingly.

To review the updated jenkins-frontend policy, execute:

```
cat jenkins-app.entitled.yml
```{{execute}}

Please note the following lines are added for entitlements.
```
# Entitlements

- !grant
  role: !group secrets-users
  member: !layer /jenkins-frontend
```

4. Load the updated policy by executing

```
conjur policy load -b jenkins-app -f jenkins-app.entitled.yml
```{{execute}}
