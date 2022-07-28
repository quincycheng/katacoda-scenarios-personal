
1. Review the jenkins-app policy by executing 

```
cat jenkins-app.entitled.yml
```{{execute}}

It declares the variables & related privileges, plus entitlements

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
conjur policy load -b jenkins-app -f jenkins-app.entitled.yml
```{{execute}}