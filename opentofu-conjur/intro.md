In this course, you will learn how to use **OpenTofu provider for Conjur** to retreive secrets from Conjur Open Source on OpenTofu.

![image](https://user-images.githubusercontent.com/4685314/180112052-84af063f-ae46-4e94-b48a-61676c691ed0.png)


First, we will make use OpenTofu to spin up a postgres database container.
A random password for the database will be generated, and it will be secured by Conjur

Next, in order for the database client to connect to the newly provisioned database, CyberArk summon will be used for secret injection.
The random password from Conjur will be retreived by the **OpenTofu provider for Conjur**
It will be then injected to the the new postgres container as an environment variable for authentication.
