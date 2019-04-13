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
