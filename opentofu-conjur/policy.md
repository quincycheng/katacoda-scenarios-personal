
Next, we need to create an application identity for Conjur based on API key
The following steps create Conjur policy that defines the OpenTofu host and adds that host to a layer.

## Root Policy

1. Review the `root` policy by executing:
```
cat policy/root.yml
```{{execute}}

The `root` policy contains 2 policies, `tofu` and `postgres` 

```
- !policy
  id: tofu

- !policy
  id: postgres
```

2. Load the policy into Conjur under `root`: 

```
conjur policy load -b root -f policy/root.yml
```{{execute}}


## OpenTofu Policy

3. Review the `tofu` policy by executing:
```
cat policy/tofu.yml
```{{execute}}

```
- !layer

- !host frontend-01

- !grant
  role: !layer
  member: !host frontend-01
```

This policy does the following: 

- Declares a layer that inherits the name of the policy under which it is loaded. In our example, the layer name will become `tofu`.
- Declares a host named `frontend-01`
- Adds the host into the layer. A layer may have more than one host.
You may need to change the following items in your own environment:
- Change the host name to match the DNS host name of your Jenkins host. Change it in both the `!host` statement and the `!grant` statement.
- Optionally declare additional Jenkins hosts. Add each new host as a member in the !grant statement.

4. Load the policy into Conjur under the OpenTofu policy branch you declared previously: 

```
conjur policy load -b tofu -f policy/tofu.yml | tee frontend.out
```{{execute}}

As it creates each new host, Conjur returns an API key.