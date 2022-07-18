*Please note that this tutorial refers to offical Conjur tutorial at https://docs.conjur.org/Latest/en/Content/Integrations/jenkins.htm, and modified for Killercoda platform.*

In this tutorial, you will learn how to secure Jenkins pipelines using Conjur & credentials plugins.

The Conjur Jenkins plugin retrieves secrets from Conjur for use in Jenkins pipeline scripts or Freestyle projects.

### Benefits
The Conjur Jenkins integration provides the following advantages to Jenkins DevOps administrators:

- **Security**. Secret values are stored and obtained securely. Secrets are not exposed in Jenkins jobs or referenced files.

- **Central management**. Secrets are managed in a central location, either in Conjur or in the CyberArk Vault if you are using the Vault Conjur Synchronizer.

- **Automatic rotation**. Secret value rotations are recommended for security. Conjur handles rotation so that no changes are required on the Jenkins side.

- **Segregation of duties**. Jenkins DevOps administrators are isolated from secrets management.

- **Segregation of duties**.The plugin supports Jenkins scripts or projects. It supports global or folder-specific configurations.

- **Simplification**. The plugin simplifies Jenkins job and project creation by requiring only a reference ID to a secret.

- **Familiarity**. The plugin is configured using the Jenkins UI, a familiar interface for Jenkins users.


[www.conjur.org](https://www.conjur.org)
