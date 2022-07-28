Next, we will configure JWT authenticator for Jenkins.
We will name it as `authn-jwt/jenkins`

We have prepared a sample policy.   
You can refer to the [official doc](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/Latest/en/Content/Operations/Services/cjr-authn-jwt-lp.htm?tocpath=Integrations%7CJWT%20Authentication%7C_____0) for details

To review the policy, execute:
```
cat authn-jwt-jenkins.yml
```{{execute}}

To load it, execute:
```
conjur policy load -b root -f authn-jwt-jenkins.yml
```{{execute}}

To set the configuration values of `authn-jwt/jenkins`, execute:
```
conjur variable set -i jenkins-app/web_password -v NotSoSecureSecret
conjur variable set -i conjur/authn-jwt/jenkins/jwks-uri -v {{TRAFFIC_HOST1_8081}}/jwtauth/conjur-jwk-set
conjur variable set -i conjur/authn-jwt/jenkins/issuer -v {{TRAFFIC_HOST1_8081}}
conjur variable set -i conjur/authn-jwt/jenkins/token-app-property -v identity
conjur variable set -i conjur/authn-jwt/jenkins/audience -v killercoda
conjur variable set -i conjur/authn-jwt/jenkins/identity-path -v /jenkins/projects
```{{execute}}