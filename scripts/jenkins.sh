#!/bin/bash

# Ensure all files are owned by Jenkins
chown -R jenkins:jenkins ${JENKINS_BASE}
chown -R jenkins:jenkins ${JENKINS_HOME}

su - jenkins -c "java -Dorg.apache.commons.jelly.tags.fmt.timeZone=${JENKINS_TZ} -Dhudson.DNSMultiCast.disabled=true -Dhudson.udp=-1 -jar ${JENKINS_BASE}/jenkins.war"
