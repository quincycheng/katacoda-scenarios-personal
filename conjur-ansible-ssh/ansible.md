
## Install Ansible

Execute the following command to install Ansible.   It may take a moment
```
apt-get update && \
apt-add-repository --yes --update ppa:ansible/ansible  && \
apt-get install ansible sshpass -y  && \
export ANSIBLE_HOST_KEY_CHECKING=False
```{{execute}}




### Verify Ansible

To verify the installation, execute:

`ansible --version`{{execute HOST1}}
