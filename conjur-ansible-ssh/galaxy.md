
We will now grant an application ID to the Ansible server.

1. Install the Conjur role using the following syntax:
```
ansible-galaxy install cyberark.conjur-host-identity
```{{execute}}

2.  Get the SSL Cert from Conjur
```
export CONJUR_URL=https://proxy:8443
openssl s_client -showcerts -servername ${CONJUR_URL#*//} -connect ${CONJUR_URL#*//} < /dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'  > conjur.pem
```{{execute}}

1. Create a host factory token
```
conjur hostfactory create token -i ansible |tee hftoken
```{{execute}}

1. Save the token & Conjur URL as environment variables
```
export HFTOKEN="$(grep token hftoken | cut -d: -f2 | tr -d ' \r\n' | tr -d ','  | tr -d '\"' )"
```{{execute}}

1. Prepare an inventory file: `cat inventory`{{execute}}

2. Prepare a playbok to grant the ansible host with Conjur Identity: `cat grant_conjur_id.yml`{{execute}}

3. Grant it!  `ansible-playbook -i inventory grant_conjur_id.yml`{{execute}}
