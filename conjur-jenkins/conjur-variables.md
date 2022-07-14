
4. Declare the variables, privileges, and entitlements. Copy the following policy as a template:

```
cat > jenkins-app.yml << EOF
#Declare the secrets required by the application

- &variables
  - !variable web_password

# Define a group and assign privileges for fetching the secrets

- !group secrets-users

- !permit
  resource: *variables
  privileges: [ read, execute ]
  roles: !group secrets-users

# Entitlements that add the Jenkins layer of hosts to the group  

- !grant
  role: !group secrets-users
  member: !layer /jenkins-frontend
EOF
```{{execute}}

This policy does the following: 
- Declares the variables to be retrieved by Jenkins.
- Declares the groups that have read & execute privileges on the variables.
- Adds the Jenkins layer to the group. The path name of the layer is relative to root.

Change the variable names, the group name, and the layer name as appropriate.

5. Load the policy into Conjur under the Jenkins policy branch you declared previously: 

`conjur policy load -b jenkins-app -f jenkins-app.yml`{{execute}}


### Set variable values in Conjur

Use the Conjur CLI or the UI to set variable values.

The CLI command to set a value is: 

`conjur variable set -i <policy-path-of-variable-name> -v <secret-value>`

For example: 

```
conjur variable set -i jenkins-app/web_password -v NotSoSecureSecret
```{{execute}}
