
To address the concerns in previous page, Conjur is used as the [secrets management solution](https://www.conjur.org/solutions/secrets-management/) to address important DevOps security attack vectors such as secret sprawl and [security islands](https://www.conjur.org/blog/security-islands/)

Not only the secret used by Jenkins will be protected, we will also elimate secret zero. [Secret zero](https://www.conjur.org/blog/secret-zero-eliminating-the-ultimate-secret/) is when all of your secrets are protected under another secrets, a single master key or ultimate secret that grants access to everything, the keys to the kingdom.

In this tutorial, we pick 3 native attribute for granting access to the secret
 - Only specific `Freestyle project` can access to the secret
 - Freestyle project name *must* be `Secure_Freestyle_Project`
 - The project must be located under folder named `Demo`

To enable this, [JWT authentication](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/Latest/en/Content/Operations/Services/cjr-authn-jwt-lp.htm?tocpath=Integrations%7CJWT%20Authentication%7C_____0) from Conjur and (Conjur Secrets Plugin](https://plugins.jenkins.io/conjur-credentials) will be used

![theimage](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/Latest/en/Content/Images/Integrations/cjr-authn-jwt-flow.png)
