In this course, you will learn how to use **OpenTofu provider for Conjur** to retreive secrets from Conjur Open Source on OpenTofu.

![image](https://github.com/quincycheng/killercoda-scenarios/assets/4685314/65391f99-d165-4207-b404-13ef76383787)

First, we will make use OpenTofu to spin up a postgres database container.
A random password for the database will be generated, and it will be secured by Conjur

Next, in order for the database client to connect to the newly provisioned database, CyberArk summon will be used for secret injection.
The random password from Conjur will be retreived by the **OpenTofu provider for Conjur**
It will be then injected to the the new postgres container as an environment variable for authentication.
