Applications and application developers should be **incapable of leaking secrets**.

To achieve that goal, you’ll play two roles in this tutorial:

1. A **Security Admin** who handles secrets, and has sole access to those secrets
2. An **Application Developer** with no access to secrets.

The situation looks like this:

TODO

Specifically, we will:

**As the security admin:**

1. Setup Conjur in Kubernetes
2. Enable Authenticator
3. Enrolling App
4. Config Secretless Broker Sidecar

**As the application developer:**
We will deploy the application in 2 different deployment optnions:
1. Deploy the application and inject secrets on start
2. Deploy the application and inject secrets on start

Let's get started!
