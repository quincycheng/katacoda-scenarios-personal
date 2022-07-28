
We will grant the jenkins projects group to use the authn-jwt/jenkins authenticator web service.

To review the policy, execute:
```
cat grant-jwt-jenkins.yml
```{{execute}}

```
# Grant the jenkins projects group to use the authn-jwt/jenkins authenticator web service
- !grant
  role: !group conjur/authn-jwt/jenkins/consumers
  member: !group jenkins/projects
```


To load it, execute:
```
conjur policy load -b root -f grant-jwt-jenkins.yml
```{{execute}}
