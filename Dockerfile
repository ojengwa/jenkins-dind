FROM jenkins/jenkins:alpine
USER root

##
## S6 Overlay && go-dnsmasq
##

ENV S6_VERSION=v1.22.1.0 GODNSMASQ_VERSION=1.0.7

RUN apk add --update wget \
  && wget https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz --no-check-certificate --quiet -O /tmp/s6-overlay.tar.gz \
  && wget https://github.com/janeczku/go-dnsmasq/releases/download/${GODNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 --no-check-certificate --quiet -O /usr/sbin/go-dnsmasq \
  && chmod +x /usr/sbin/go-dnsmasq \
  && tar xvfz /tmp/s6-overlay.tar.gz -C / \
  && rm -f /tmp/s6-overlay.tar.gz \
  && apk del wget \
  && rm -rf /var/cache/apk/*


COPY rootfs /


# Install Docker and shadow (for groupadd / usermod etc)
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && apk add --update --no-cache docker shadow su-exec

RUN install-plugins.sh  \
  ace-editor \
  ant \
  antisamy-markup-formatter \
  authentication-tokens \
  bitbucket \
  bitbucket-build-status-notifier \
  bitbucket-oauth \
  bitbucket-pullrequest-builder \
  bitbucket-push-and-pull-request \
  blueocean \
  blueocean-autofavorite \
  blueocean-bitbucket-pipeline \
  blueocean-commons \
  blueocean-config \
  blueocean-dashboard \
  blueocean-display-url \
  blueocean-events \
  blueocean-git-pipeline \
  blueocean-i18n \
  blueocean-jwt \
  blueocean-personalization \
  blueocean-pipeline-api-impl \
  blueocean-pipeline-editor \
  blueocean-pipeline-scm-api \
  blueocean-rest \
  blueocean-rest-impl \
  blueocean-web \
  bouncycastle-api \
  branch-api \
  build-timeout \
  cloudbees-bitbucket-branch-source \
  cloudbees-folder \
  credentials \
  credentials-binding \
  display-url-api \
  docker \
  docker-workflow \
  durable-task \
  email-ext \
  external-monitor-job \
  favorite \
  git \
  global-build-stats \
  handlebars \
  icon-shim \
  jackson2-api \
  jquery-detached \
  junit \
  keycloak \
  mailer \
  matrix-auth \
  matrix-project \
  metrics \
  momentjs \
  pam-auth \
  pipeline-build-step \
  pipeline-graph-analysis \
  pipeline-input-step \
  pipeline-milestone-step \
  pipeline-model-api \
  pipeline-model-declarative-agent \
  pipeline-model-definition \
  pipeline-model-extensions \
  pipeline-rest-api \
  pipeline-stage-step \
  pipeline-stage-tags-metadata \
  pipeline-stage-view \
  plain-credentials \
  pubsub-light \
  purge-job-history \
  resource-disposer \
  role-strategy \
  scm-api \
  script-security \
  simple-theme-plugin \
  sse-gateway \
  ssh-credentials \
  ssh-slaves \
  structs \
  timestamper \
  token-macro \
  variant \
  windows-slaves \
  workflow-aggregator \
  workflow-api \
  workflow-basic-steps \
  workflow-cps \
  workflow-cps-global-lib \
  workflow-durable-task-step \
  workflow-job \
  workflow-multibranch \
  workflow-scm-step \
  workflow-step-api \
  workflow-support \
  ws-cleanup


COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

##
## Init
##
CMD ["/init"]
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
