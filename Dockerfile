FROM ubuntu:18.04
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV JENKINS_BASE /opt/jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV JENKINS_TZ Australia/Sydney
ENV CORRETTO_URL https://d3pxv6yz143wms.cloudfront.net/8.222.10.1/java-1.8.0-amazon-corretto-jdk_8.222.10-1_amd64.deb
ENV DOCKER_GID 999
EXPOSE 8080/tcp

# Install Java and minimum requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y java-common fontconfig libfreetype6 curl wget bash git sudo wget rsync openssh-client libltdl7 python python-pip python3 python3-pip && \
    curl ${CORRETTO_URL} -O && \
    dpkg --install java-*.deb && \
    pip3 install awscli && \
    java -version

# Setup and Install Jenkins and add Docker user group
ADD scripts /opt/jenkins-scripts

RUN chmod 700 /opt/jenkins-scripts/jenkins.sh && mkdir -p ${JENKINS_BASE} && wget -O ${JENKINS_BASE}/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war && \
    adduser  --disabled-password --gecos '' --home ${JENKINS_HOME} jenkins && pip3 install boto3 && groupadd -g ${DOCKER_GID} docker && usermod -a -G docker jenkins

ENTRYPOINT ["/opt/jenkins-scripts/jenkins.sh"]
