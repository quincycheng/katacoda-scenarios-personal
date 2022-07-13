

Here comes a typical ansible playbook & inventory

### Inventory file 

First, we will need to create an inventory file about our servers

```
mkdir insecure-playbook
cat <<EOF > insecure-playbook/inventory
[demo_servers]
host01 ansible_connection=ssh ansible_host=[[HOST_IP]] ansible_ssh_user=service01 ansible_ssh_pass=W/4m=cS6QSZSc*nd
host02 ansible_connection=ssh ansible_host=[[HOST2_IP]] ansible_ssh_user=service02 ansible_ssh_pass=5;LF+J4Rfqds:DZ8
EOF 
```{{execute}}

### The Playbook

```
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
```{{execute}}

### Test

`ansible-playbook -i insecure-playbook/inventory insecure-playbook/insecure-playbook.yml`{{execute}}