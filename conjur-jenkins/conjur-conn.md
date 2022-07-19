
The following steps define the connection to Conjur. This is typically a one-time configuration.
In case your Jenkins session has been time-out, Jenkins user name is `admin`{{copy}} and password is `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

### Add Conjur API Key to Jenkins

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

