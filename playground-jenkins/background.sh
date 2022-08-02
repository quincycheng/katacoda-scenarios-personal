cat <<'EOF' > docker-compose.yml
version: '3'
services:
  jenkins:
    image: jenkins/jenkins:lts
    privileged: true
    user: root
    ports:
      - 8081:8080
      - 50000:50000
    container_name: jenkins
    environment:
      JAVA_OPTS: "-Djenkins.model.Jenkins.crumbIssuerProxyCompatibility=true"
      xJAVA_OPTS: "-Djenkins.model.Jenkins.crumbIssuerProxyCompatibility=true -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true -Djenkins.install.runSetupWizard=false"
EOF

docker-compose up -d


