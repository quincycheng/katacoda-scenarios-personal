
The Conjur Jenkins integration provides the following advantages to Jenkins DevOps administrators:

- **Security**. Secret values are stored and obtained securely. Secrets are not exposed in Jenkins jobs or referenced files.

- **Central management**. Secrets are managed in a central location, centralized in CyberArk PAM as single source of truth while Conjur is distributed near/on the same platform as Jenkins

- **Automatic rotation**. Secret value rotations are recommended for security. Conjur, together with CyberArk PAM, handles rotation so that no changes are required on the Jenkins side.

- **Segregation of duties**. Jenkins DevOps administrators are isolated from secrets management.

- **Segregation of duties**.The plugin supports Jenkins scripts or projects. It supports global or folder-specific configurations.

- **Simplification**. The plugin simplifies Jenkins job and project creation by requiring only a reference ID to a secret.

- **Familiarity**. The plugin is configured using the Jenkins UI, a familiar interface for Jenkins users