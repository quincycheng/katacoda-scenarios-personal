
### Configure Conjur in Jenkins

We will setup a global access to Conjur in this tutorial.

You can decide whether to set up global or folder-level access to Conjur, or a combination of both.
To learn more, visit [CyberArk Conjur Doc](https://docs.conjur.org/Latest/en/Content/Integrations/jenkins-configure.htm?tocpath=Integrations%7CJenkins%7C_____2#ConfigureJenkinsConjurconnection)

1. Navigate to `Jenkins` > `Manage Jenkins` > [Configure System]({{TRAFFIC_HOST1_8081}}/configure)

2. Scroll down to `Conjur Appliance`

3. Fill in the form

- Account: `default`{{copy}}
- Appliance URL: `{{TRAFFIC_HOST1_8081}}`{{copy}}
- Conjur Authn Credential: `host/jenkins-frontend/frontend-01/*****`{{copy}}
 - 
 -
 -
 -
 -
 -
 -



7. Click `Save`
