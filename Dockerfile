FROM amazoncorretto:11
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV JENKINS_BASE /opt/jenkins
ENV JENKINS_HOME /var/lib/jenkins
ENV JENKINS_TZ Australia/Sydney
ENV DOCKER_GID 999
EXPOSE 8080/tcp

# Install Java and minimum requirements
RUN yum install -y freetype curl git wget rsync openssh-clients python python-pip python3 python3-pip && \
    pip3 install awscli boto3

# Setup and Install Jenkins and add Docker user group
ADD scripts /opt/jenkins-scripts

RUN chmod 700 /opt/jenkins-scripts/jenkins.sh && mkdir -p ${JENKINS_BASE} && wget -O ${JENKINS_BASE}/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war && \
    adduser --home ${JENKINS_HOME} jenkins && groupadd -g ${DOCKER_GID} docker && usermod -a -G docker jenkins

ENTRYPOINT ["/opt/jenkins-scripts/jenkins.sh"]
