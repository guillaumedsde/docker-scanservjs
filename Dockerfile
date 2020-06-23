FROM node:alpine AS builder

ARG APP_DIR=/app
ARG S6_VERSION=v2.0.0.1
WORKDIR "$APP_DIR"

RUN apk add --no-cache git  \
    && git clone https://github.com/sbs20/scanservjs.git .

# install build dependencies
RUN npm install

# run a gulp build
COPY . "$APP_DIR"
RUN npm run build

RUN cp -r node_modules/bootstrap/dist/* build/scanservjs/assets/

WORKDIR /rootfs

RUN ARCH="$(uname -m)" \
    && echo building for "${ARCH}" \
    && if [ "${ARCH}" = "x86_64" ]; then S6_ARCH=amd64; \
    elif [ "${ARCH}" = "i386" ]; then S6_ARCH=X86; \
    elif echo "${ARCH}" | grep -E -q "armv6|armv7"; then S6_ARCH=arm; \
    else S6_ARCH="${ARCH}"; \
    fi \
    && echo using architecture "${S6_ARCH}" for S6 Overlay \
    && wget -O "s6.tgz" "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz" \
    && tar xzf "s6.tgz" -C . \ 
    && rm "s6.tgz"

WORKDIR "/rootfs$APP_DIR"

RUN cp -r "$APP_DIR/build/scanservjs/." .

RUN npm install --production

COPY rootfs /rootfs

# production image
FROM node:alpine

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
    NODE_ENV="production"

WORKDIR "$APP_DIR"

# Install sane
RUN apk add --no-cache \
    sane \
    sane-utils \
    sane-backends \
    sane-udev \
    imagemagick 

COPY --from=builder /rootfs /

EXPOSE 8080

ENTRYPOINT [ "/init" ]

