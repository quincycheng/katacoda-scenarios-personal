
# Setup 

Let's setup the environment by executing the following commands:

```
cat > ./jenkins_home/jenkins.model.JenkinsLocationConfiguration.xml << EOF
<?xml version='1.1' encoding='UTF-8'?>
<jenkins.model.JenkinsLocationConfiguration>
  <adminAddress>address not configured yet &lt;nobody@nowhere&gt;</adminAddress>
  <jenkinsUrl>{{TRAFFIC_HOST1_8081}}</jenkinsUrl>
</jenkins.model.JenkinsLocationConfiguration>
EOF
sleep 1s && \
docker-compose up -d  && \
echo "$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' conjur_server) conjur" >> /etc/hosts
```{{execute}}

You should be able to access various systems on this environment by accessing the following links:

- [Jenkins (port 8081)]({{TRAFFIC_HOST1_8081}})
- [Target Web System with authenication enabled (port 8082)]({{TRAFFIC_HOST1_8082}})
- [Conjur (port 8080)]({{TRAFFIC_HOST1_8080}})

They are all run as containers.   
To verify, execute `docker ps`{{execute}}

![theimage](https://github.com/quincycheng/katacoda-scenarios/raw/master/conjur-jenkins/media/00-docker.PNG)

The response doesn't look the similar?  Don't worry, please give them a moment to start.
You can retry the above command anytime.

