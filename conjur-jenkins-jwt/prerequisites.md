
The environment is being setup for you

Wait for the "Ready! 😀" message on the right to begin

Once ready, you should be able to access various systems on this environment by accessing the following links:

- [Jenkins (port 8081)]({{TRAFFIC_HOST1_8081}})
- [Target Web System with authenication enabled (port 8082)]({{TRAFFIC_HOST1_8082}})
- [Conjur (port 8080)]({{TRAFFIC_HOST1_8080}})

They are all run as containers.   
To verify, execute `docker ps`{{execute}}

![theimage](https://github.com/quincycheng/katacoda-scenarios/raw/master/conjur-jenkins/media/00-docker.PNG)

The response doesn't look the similar?  Don't worry, please give them a moment to start.
You can retry the above command anytime.

