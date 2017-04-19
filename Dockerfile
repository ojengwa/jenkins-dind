FROM jenkinsci/blueocean:latest

VOLUME /var/run/docker.sock
USER root

# Install Docker and shadow (for groupadd / usermod etc)
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk add --update docker shadow 

COPY entrypoint.sh /
ENTRYPOINT entrypoint.sh