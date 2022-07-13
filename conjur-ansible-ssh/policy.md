The sample policies have been prepared for you. 

**Root policy**

Run `cat conjur.yml`{{execute}} to review the root policy
```
- !policy
  id: db

- !policy
  id: ansible
```
**db policy**

Run `cat db.yml`{{execute}} to review the root policy

```
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

```

**ansible policy**

Run `cat ansible.yml`{{execute}} to review the root policy

```
- !layer
- !host ansible-01
- !grant
  role: !layer
  member: !host ansible-01
```
### Load Conjur Policies

Now let's copy the policy files to Conjur CLI container and load them

**Load Root Policy**

```
conjur policy load -b root -f conjur.yml
```{{execute}}

**Load ansible Policy**
```
conjur policy load -b ansible -f ansible.yml | tee ansible.out
```{{execute}}

**Load db Policy**
```
conjur policy load -b db -f db.yml
```{{execute}}

### Set variable
Let's set the value of variables accordingly


```
conjur variable set -i db/host1/host -v "172.17.0.2" && \
conjur variable set -i db/host1/user -v "service01" && \
conjur variable set -i db/host1/pass -v "W/4m=cS6QSZSc*nd" && \
conjur variable set -i db/host2/host -v "172.17.0.3" && \
conjur variable set -i db/host2/user -v "service02" && \
conjur variable set -i db/host2/pass -v "5;LF+J4Rfqds:DZ8"
```{{execute}}