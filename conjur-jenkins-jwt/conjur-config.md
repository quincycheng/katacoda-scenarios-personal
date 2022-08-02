
### Configure Conjur in Jenkins

We will setup access to Conjur

1. Navigate to `Jenkins` > `Manage Jenkins` > [Configure System]({{TRAFFIC_HOST1_8081}}/configure)

2. Scroll down to `Conjur Appliance` & fill in:

    - Account: `default`{{copy}}
    - Appliance URL: `https://proxy`{{copy}}
    - Conjur Auth Credential: `- none -`
    - Conjur SSL Certificate: `CN=proxy, OU=Onyx, O=Cyberark, L=Madison, ST=Wisconsin, C=US`

3. Scroll down to `Conjur JWT Authentication` & fill in:
    - Check `Enable JWT Key Set endpoint?`
    - Auth WebService ID: `jenkins`{{copy}}
    - JWT Audience: `killercoda`{{copy}}
    - Check `Enable Context Aware Credential Stores?`
    - Identity Format Fields: `aud,jenkins_name`

4. Leave everything else default and click `Save`
