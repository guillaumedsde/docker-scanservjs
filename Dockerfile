ARG VERSION=HEAD

FROM node:14-alpine3.12 AS builder

ARG S6_VERSION=v2.0.0.1
ARG VERSION
WORKDIR /app

# hadolint ignore=DL3018
RUN apk add --no-cache git python2 build-base \
    && git clone https://github.com/sbs20/scanservjs.git . &&\
    git checkout "${VERSION}"

# install build dependencies
RUN npm ci

# run a gulp build
RUN npm run server-build && npm run client-build

WORKDIR /rootfs/app

RUN mv /app/dist/* ./

RUN npm ci --only=production

COPY rootfs /rootfs

# production image
FROM node:14-alpine3.12

ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="docker-scanservjs" \
    org.label-schema.description="scanservjs docker container on alpine linux" \
    org.label-schema.url="https://guillaumedsde.gitlab.io/docker-scanservjs/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/docker-scanservjs" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

ENV APP_DIR="/app" \
    NET_HOST="" \
    NODE_ENV="production" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

WORKDIR /app

# Install sane
# hadolint ignore=DL3018
RUN apk add --no-cache \
    sane \
    sane-utils \
    sane-backends \
    sane-udev \
    imagemagick \
    tesseract-ocr \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    s6-overlay

COPY --from=builder /rootfs /

EXPOSE 8080

ENTRYPOINT [ "/init" ]

