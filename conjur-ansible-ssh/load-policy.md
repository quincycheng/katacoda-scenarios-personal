
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