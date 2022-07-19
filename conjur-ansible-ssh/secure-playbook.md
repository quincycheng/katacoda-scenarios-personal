

Let's convert the conjur identity to make it compatible with Ansible:
```
sed -i "s=login host/=login host%2F=" /etc/conjur.identity
sed -i '/cert_file/d' /etc/conjur.conf
```{{execute}}

Let's review the sample inventory, which stores the 2 servers
```
cat secure-playbook/inventory
```{{execute}}

Let's review the sample playbook, which connects to 
```
cat secure-playbook/secure-playbook.yml
```{{execute}}

To execute the playbook:
```
ansible-playbook -i secure-playbook/inventory secure-playbook/secure-playbook.yml
```{{execute}}

The result should contains the following message:
```
TASK [debug] *******************************************************************
ok: [host1] => {
    "msg": "I am  service01 at controlplane"
}
ok: [host2] => {
    "msg": "I am  service02 at node01"
}
```