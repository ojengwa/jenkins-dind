FROM jenkinsci/jenkins:alpine
USER root

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
    blueocean-github-pipeline \
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
    docker-commons \
    docker-workflow \
    durable-task \
    email-ext \
    external-monitor-job \
    favorite \
    git \
    git-client \
    git-server \
    global-build-stats \
    gradle \
    handlebars \
    icon-shim \
    jackson2-api \
    jquery-detached \
    junit \
    keycloak \
    ldap \
    mailer \
    mapdb-api \
    matrix-auth \
    matrix-project \
    metrics \
    momentjs \
    pam-auth \
    pipeline-build-step \
    pipeline-github-lib \
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
    subversion \
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
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
