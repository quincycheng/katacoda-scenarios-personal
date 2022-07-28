
We will define the application identities of Jenkins.
In this tutorial, it will based on the project that we are going to create.
Let's name it as `Secure_Freestyle_Project`

To review the policy, execute:
```
cat jenkins-projects.yml
```{{execute}}

The following lines specify the folder name `Demo`, the type of the item `Project` and the identity `killercoda-Secure_Freestyle_Project`
```
- !host
    id: Secure_Freestyle_Project
    annotations:
    description: Freestyle project in Jenkins named Secure_Freestyle_Project in the Demo folder.
    jenkins: true
    project_url: na
    authn-jwt/jenkins/jenkins_parent_name: Demo
    authn-jwt/jenkins/jenkins_pronoun: Project
    authn-jwt/jenkins/identity: killercoda-Secure_Freestyle_Project
```

To load it, execute:
```
conjur policy load -b jenkins -f jenkins-projects.yml
```{{execute}}

