ARG DOCKER_VERSION=${DOCKER_VERSION:-"19.03.2"}

FROM docker:${DOCKER_VERSION}

RUN apk add --no-cache bash
RUN set -x && \
  apk add --no-cache -t .deps ca-certificates curl && \
  # Install glibc on Alpine (required by docker-compose) from
  # https://github.com/sgerrand/alpine-pkg-glibc
  # See also https://github.com/gliderlabs/docker-alpine/issues/11
  GLIBC_VERSION='2.28-r0' && \
  curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
  curl -Lo glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk && \
  curl -Lo glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk && \
  apk update && \
  apk add glibc.apk glibc-bin.apk && \
  rm -rf /var/cache/apk/* glibc.apk glibkc-bin.apk && \
  \
  # Clean-up
  apk del .deps

ARG DOCKER_COMPOSE_VERSION
ENV DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION:-"1.24.0"}

RUN set -x && \
  apk add --no-cache -t .deps ca-certificates curl && \
  curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
  chmod a+rx /usr/local/bin/docker-compose && \
  \
  # Basic check it works
  docker-compose version && \
  \
  # Clean-up
  apk del .deps

SHELL [ "/bin/bash", "-c" ]

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG DOCKER_VERSION

LABEL org.label-schema.schema-version="1.0" \
  org.label-schema.vendor="Territory Embrace | Talentplatforms" \
  org.label-schema.vcs-url="${VCS_URL}" \
  org.label-schema.vcs-ref="${VCS_REF}" \
  org.label-schema.name="docker-compose" \
  org.label-schema.version="docker-compose-docker-${DOCKER_VERSION}" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.description="tooling for the pipelines"
