

We will define the secrets and related privileges, plus entitlements

To review the jenkins-app policy, execute:
```
cat jenkins-app.yml
```{{execute}}


```
- &variables
  - !variable web_password

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements

- !grant
  role: !group secrets-users
  member: !group /conjur/authn-jwt/jenkins/consumers
```
This policy does the following: 
- Declares the variables to be retrieved by Jenkins.
- Declares the groups that have read & execute privileges on the variables.
- Adds the Jenkins group to the `secrets-users` group. 

To load the policy into Conjur under the `jenkins-app` policy branch you declared previously: 

```
conjur policy load -b jenkins-app -f jenkins-app.yml
```{{execute}}