#!/bin/sh

# Find GID of docker group
DOCKER_GID=`ls -n /var/run/docker.sock | awk '{ print $4 }'`

# Create docker group and add jenkins user to it
getent group docker || groupadd -g $DOCKER_GID docker && usermod -aG docker jenkins

# Run jenkins as jenkins
su-exec jenkins /usr/local/bin/jenkins.sh
