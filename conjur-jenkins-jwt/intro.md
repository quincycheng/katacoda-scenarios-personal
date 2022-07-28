
In this tutorial, you will learn how to secure Jenkins pipelines using Conjur & credentials plugins.
The Conjur Jenkins plugin retrieves secrets from Conjur for use in Jenkins pipeline scripts or Freestyle projects.

![image](https://user-images.githubusercontent.com/4685314/179661213-5b74a974-aee5-4f99-837f-deb1d92e87af.png)

The sample pipeline will trigger Jenkins to access the target web apps with HTTP authentication.
We will focus on the secrets used and secure it using Conjur.

*Please note that this tutorial refers to offical Conjur tutorial at https://docs.conjur.org/Latest/en/Content/Integrations/jenkins.htm, and modified for Killercoda platform.*
