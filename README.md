# Jenkins Docker image

A Jenkins Docker image run using Amazon's Corretto

# Building Jenkins

```
docker build . -f Dockerfile -t docker-jenkins
```

# Running Jenkins

The basic minimum requirements to get Jenkins to run using this Docker image

```
mkdir -p /var/jenkins-data
docker run d -p 8080:8080/tcp -v /var/jenkins-data:/var/lib/jenkins --rm docker-jenkins
```

# Environment Variables

Varaible | Default | Description
-------- | ------- | -----------
JENKINS_BASE | /opt/jenkins | Where jenkins.war will be saved and executed from
JENKINS_HOME | /var/lib/jenkins | Where Jenkins data will be stored
JENKINS_TZ | Australia/Sydney | Timezone for our Java runtime
CORETTO_URL | N/A | Corretto Download URL
DOCKER_GID | 999 | Docker Group ID to use the Docker CLI

Please build this container replacing the DOCKER_GID environment variable if Docker is using a different group id on your machine.
