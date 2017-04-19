#!/bin/sh

# Find GID of docker group
DOCKER_GID=`stat -c %g /var/run/docker.sock`

# Recreate docker group and add jenkins user to it
groupdel docker
getent group docker || groupadd -g $DOCKER_GID docker && usermod -aG docker jenkins

# Run jenkins as jenkins
su-exec jenkins /usr/local/bin/jenkins.sh