FROM ubuntu:18.04
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV JENKINS_BASE /opt/jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV JENKINS_TZ Australia/Sydney
ENV CORRETTO_URL https://d2znqt9b1bc64u.cloudfront.net/java-1.8.0-amazon-corretto-jdk_8.202.08-2_amd64.deb
ENV DOCKER_GID 999
EXPOSE 8080/tcp

# Install Java and minimum requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y java-common fontconfig libfreetype6 curl wget bash git sudo wget rsync openssh-client python python-pip python3 python3-pip && \
    curl ${CORRETTO_URL} -O && \
    dpkg --install java-*.deb && \
    pip3 install awscli && \
    java -version \
    groupadd -g ${DOCKER_GID} docker && usermod -a -g docker jenkins

# Setup and Install Jenkins
ADD scripts /opt/jenkins-scripts

RUN mkdir -p ${JENKINS_BASE} && wget -O ${JENKINS_BASE}/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war && \
    adduser  --disabled-password --gecos '' --home ${JENKINS_HOME} jenkins && pip3 install boto3

ENTRYPOINT ["/opt/jenkins-scripts/jenkins.sh"]
