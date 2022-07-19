
The following steps define the connection to Conjur. This is typically a one-time configuration.
In case your Jenkins session has been time-out, Jenkins user name is `admin`{{copy}} and password is `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

1. Navigate to Manage Jenkins > Manage Credentials > (global) > Add Credentials, the [Global credentials (unrestricted)]({{TRAFFIC_HOST1_8081}}/credentials/store/system/domain/_/newCredentials) page should be shown

2. On the form that appears, configure the login credentials for the Jenkins host to log into Conjur.

![theimage](https://github.com/quincycheng/katacoda-scenarios/raw/master/conjur-jenkins/media/04-conn.PNG)

 - Username: `host/jenkins-frontend/frontend-01`{{copy}}
 - Password: 

  Copy and paste the API key that was returned by Conjur when you loaded the policy declaring this host.
  To review it, execute:
  ```
  cat frontend.out
  ```{{execute}}

3. Click `OK`

You can also decide whether to set up global or folder-level access to Conjur, or a combination of both.

To learn more, visit [CyberArk Conjur Doc](https://docs.conjur.org/Latest/en/Content/Integrations/jenkins-configure.htm?tocpath=Integrations%7CJenkins%7C_____2#ConfigureJenkinsConjurconnection)


4. Navigate to either Jenkins > Manage Jenkins > [Configure System]({{TRAFFIC_HOST1_8081}}/configure)

5. Scroll down to "Conjur Appliance"

6. Fill in the form

- Account: `default`{{copy}}
- Appliance URL: `http://172.30.1.2:8080`{{copy}}
- Conjur Authn Credential: `host/jenkins-frontend/frontend-01/*****`{{copy}}

7. Click `Save`
