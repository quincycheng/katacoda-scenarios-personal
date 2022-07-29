Next, we will configure JWT authenticator for Jenkins.
We will name it as `authn-jwt/jenkins`

We have prepared a sample policy with the following variables:
- `jwks-url` provides the resource for a set of JSON-encoded public keys, one of which corresponds to the key used to digitally sign the JWT.  It enables verification of JSON token from Jenkins.
- `token-app-property` to create a 1:1 mapping between the JWT Authenticator and the authenticating application. We will align this with plugin configuration.
- `identity-path` defines the app ID's path in Conjur, thereby completing the full app ID name.
- `issuer` validates the issuer of the JWT.
- `audience` is a custom string which will be aligned with plugin configuration.

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
conjur variable set -i conjur/authn-jwt/jenkins/jwks-uri -v {{TRAFFIC_HOST1_8081}}/jwtauth/conjur-jwk-set
conjur variable set -i conjur/authn-jwt/jenkins/token-app-property -v identity
conjur variable set -i conjur/authn-jwt/jenkins/identity-path -v /jenkins/projects
conjur variable set -i conjur/authn-jwt/jenkins/audience -v killercoda
conjur variable set -i conjur/authn-jwt/jenkins/issuer -v {{TRAFFIC_HOST1_8081}}
```{{execute}}