

Visiti Jenkins > Demo > Credentials > Folder > Global credentials (unrestricted) > [Add Credentials]({{TRAFFIC_HOST1_8081}}/job/Demo/credentials/store/folder/domain/_/newCredentials) to create a new credential

-  Kind: Conjur Secret Credentials
-  Variable Path: `jenkins-app/web_password`{{copy}}
-  ID: `WEB_PASSWORD`{{copy}}
  
This is the complete Conjur ID of the variable. This includes the policy path where the variable is defined.

Click `OK` to save it

In case you get an error, you can verify the credential at ({{TRAFFIC_HOST1_8081}}/job/Demo/credentials/store/folder/domain/_/