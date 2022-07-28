
```
conjur policy load -b root -f root.yml
conjur policy load -b root -f authn-jwt-jenkins.yml
conjur policy load -b jenkins -f jenkins-projects.yml
conjur policy load -b root -f grant-jwt-jenkins.yml
conjur policy load -b jenkins-app -f jenkins-app.yml
```{{execute}}

```
conjur variable set -i jenkins-app/web_password -v NotSoSecureSecret
conjur variable set -i conjur/authn-jwt/jenkins/jwks-uri -v {{TRAFFIC_HOST1_8081}}/jwtauth/conjur-jwk-set
conjur variable set -i conjur/authn-jwt/jenkins/issuer -v {{TRAFFIC_HOST1_8081}}
conjur variable set -i conjur/authn-jwt/jenkins/token-app-property -v identity
conjur variable set -i conjur/authn-jwt/jenkins/audience -v killercoda
conjur variable set -i conjur/authn-jwt/jenkins/identity-path -v /jenkins/projects

```{{execute}}




JWT Token:
{
    "aud": "killercoda",
    "sub": "anonymous",
    "jenkins_name": "Demo",
    "nbf": 1658996849,
    "jenkins_url_child_prefix": "job",
    "identity": "killercoda-Demo",
    "jenkins_full_name": "Demo",
    "iss": "https://29ea74ee-eac3-4656-9ae4-11dc034c19c7-10-244-5-5-8081.papa.r.killercoda.com",
    "jenkins_task_noun": "Build",
    "exp": 1658996999,
    "iat": 1658996879,
    "jti": "ac1ef748f54949588a9c176adac7da60"
}




add-apt-repository -y ppa:deadsnakes/ppa && \
apt install -y python3.10 python3.10-distutils && \
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 && \
python3.10 -m pip install conjur==7.1.0


conjur list  --privilege 'authenticate' --permitted-roles 'webservice:conjur/authn-jwt/jenkins'

conjur list --k group --privilege 'authenticate' --permitted-roles 'webservice:conjur/authn-jwt/jenkins'
[
    "default:user:admin",
    "default:group:conjur/authn-jwt/jenkins/consumers",
    "default:host:jenkins/projects/Secure_Freestyle_Project",
    "default:policy:jenkins",
    "default:policy:jenkins/projects",
    "default:group:jenkins/projects",
    "default:policy:conjur/authn-jwt/jenkins"
]