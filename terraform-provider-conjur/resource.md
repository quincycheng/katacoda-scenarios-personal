
1. Review the postgres policy by executing 

```
cat policy/postgres.yml
```{{execute}}

It declares the variables & related privileges, plus entitlements

```
#Declare the secrets required by the application

- &variables
  - !variable admin-password

# Define a group and assign privileges for fetching the secrets

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements that add the Jenkins layer of hosts to the group  

- !grant
  role: !group secrets-users
  member: !layer /terraform
```

This policy does the following: 
- Declares the variables to be retrieved by Terraform.
- Declares the groups that have read & execute privileges on the variables.
- Adds the Terraform layer to the group. The path name of the layer is relative to root.

Change the variable names, the group name, and the layer name as appropriate.

2. Load the policy into Conjur under the `postgres` policy branch you declared previously: 

```
conjur policy load -b postgres -f policy/postgres.yml
```{{execute}}

### Add variable
Let's create a secret and add it to Conjur

```
dbpass=$(openssl rand -hex 12)
conjur variable set -i postgres/admin-password -v "$dbpass" 
```{{execute}}
