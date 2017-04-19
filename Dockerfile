FROM jenkinsci/blueocean:latest
USER root

# Install Docker and shadow (for groupadd / usermod etc)
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" > /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && apk add --update --no-cache docker shadow su-exec

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/bin/tini", "--", "/entrypoint.sh"]
