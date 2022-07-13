
We will now grant an application ID to the Ansible server.

1. Install the Conjur role using the following syntax:
```
ansible-galaxy install cyberark.conjur-host-identity
```{{execute}}

2.  Get the SSL Cert from Conjur
```
openssl s_client -showcerts -connect {{TRAFFIC_HOST1_8080}} < /dev/null 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > <file-name>
```{{execute}}

3. Create a host factory token
```
conjur hostfactory create token -i ansible -m 30|tee hftoken
```{{execute}}

4. Save the token as environment 
```
export HFTOKEN="$(grep token hftoken | cut -d: -f2 | tr -d ' \r\n' | tr -d ','  | tr -d '\"' )"
```{{execute}}

5. Prepare an inventory file: `cat inventory`{{execute}}

6. Prepare a playbok to grant the ansible host with Conjur Identity: `cat grant_conjur_id.yml`{{execute}}

7. Grant it!  `ansible-playbook -i inventory grant_conjur_id.yml`{{execute}}
