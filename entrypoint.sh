# Find GID of docker group
DOCKER_GID=`ls -n /var/run/docker.sock | awk '{ print $4 }'`

# Create docker group and add jenkins user to it
getent group docker || groupadd -g $DOCKER_GID docker && usermod -aG docker jenkins

# Switch to user jenkins
su jenkins

# Start Jenkins
/bin/tini /usr/local/bin/jenkins.sh