#!/bin/bash

curl -o docker-compose.yml https://quincycheng.github.io/docker-compose.conjur2022.yml && \
docker-compose pull & 

mkdir insecure-playbook
cat <<EOF > insecure-playbook/inventory
[demo_servers]
host01 ansible_connection=ssh ansible_host=172.17.0.2 ansible_ssh_user=service01 ansible_ssh_pass=W/4m=cS6QSZSc*nd
host02 ansible_connection=ssh ansible_host=172.17.0.3 ansible_ssh_user=service02 ansible_ssh_pass=5;LF+J4Rfqds:DZ8
EOF
cat <<EOF > insecure-playbook/insecure-playbook.yml
- hosts: demo_servers
  tasks:
    - name: Get user name
      shell: whoami
      register: theuser

    - name: Get host name
      shell: hostname
      register: thehost

    - debug: msg="I am {{ theuser.stdout }} at {{ thehost.stdout }}"
EOF

mkdir secure-playbook
cat <<EOF > secure-playbook/inventory
[demo_servers]
host1
host2
EOF

cat <<EOF > secure-playbook/secure-playbook.yml
- hosts: demo_servers
  vars:
      ansible_connection: ssh      
      ansible_host: "{{ lookup('conjur_variable', 'db/' + inventory_hostname+ '/host') }}"
      ansible_user: "{{ lookup('conjur_variable', 'db/' + inventory_hostname+ '/user') }}"
      ansible_ssh_pass: "{{ lookup('conjur_variable', 'db/' + inventory_hostname+ '/pass') }}"

  tasks:
    - name: Get user name
      shell: whoami
      register: theuser

    - name: Get host name
      shell: hostname
      register: thehost

    - debug: msg="I am {{ theuser.stdout }} at {{ thehost.stdout }}"
EOF

cat <<EOF > conjur.yml
- !policy
  id: db

- !policy
  id: ansible
EOF

cat <<EOF > ansible.yml
- !layer

- !host ansible-01

- !grant
  role: !layer
  member: !host ansible-01

- !host-factory
  layers: [ !layer ]
EOF

cat <<EOF > db.yml
- &variables
  - !variable host1/host
  - !variable host1/user
  - !variable host1/pass
  - !variable host2/host
  - !variable host2/user
  - !variable host2/pass

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements 
- !grant
  role: !group secrets-users
  member: !layer /ansible
EOF

cat <<EOF > grant_conjur_id.yml
- hosts: servers
  roles:
    - role: cyberark.conjur-host-identity
      conjur_appliance_url: "{{lookup('env', 'CONJUR_URL')}}"
      conjur_account: "demo"
      conjur_host_factory_token: "{{lookup('env', 'HFTOKEN')}}"
      conjur_host_name: "{{inventory_hostname}}"
      conjur_ssl_certificate:  "{{lookup('file', 'conjur.pem')}}"
      conjur_validate_certs: "true"
EOF

cat <<EOF > inventory
[servers]
localhost
EOF

docker run --name sshd1 -P -d quincycheng/killercoda-sshd-host:latest && \
docker run --name sshd2 -P -d quincycheng/killercoda-sshd-host:latest 