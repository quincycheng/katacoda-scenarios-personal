
We will create 2 policies under `root` policy:
- `jenkins` policy for Jenkins JWT authentication 
- `jenkins-app` for protected secrets used by Jenkins

To review the `root` policy, execute:
```
cat root.yml
```{{execute}}

```
- !policy
  id: jenkins

- !policy
  id: jenkins-app
```

To load the `root` policy, execute:
```
conjur policy load -b root -f root.yml
```{{execute}}

