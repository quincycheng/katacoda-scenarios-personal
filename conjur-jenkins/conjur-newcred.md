

 Add a new secret for the pipeline by navigating to Manage `Jenkins` > `Manage Credentials` > `(global)` > `Add Credentials`, the [Global credentials (unrestricted)]({{TRAFFIC_HOST1_8081}}/credentials/store/system/domain/_/newCredentials) page should be shown

-  Kind: Conjur Secret Credentials
-  Variable Path: `jenkins-app/web_password`{{copy}}
-  ID: `WEB_PASSWORD`{{copy}}
  
This is the complete Conjur ID of the variable. This includes the policy path where the variable is defined.

Click `OK` to save it