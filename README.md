# [🐋 docker-scanservjs](https://github.com/guillaumedsde/docker-scanservjs)

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/guillaumedsde/docker-scanservjs)](https://gitlab.com/guillaumedsde/docker-scanservjs/-/pipelines)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/guillaumedsde/docker-scanservjs)](https://gitlab.com/guillaumedsde/docker-scanservjs/-/pipelines)
[![Website](https://img.shields.io/website?label=documentation&url=https%3A%2F%2Fguillaumedsde.gitlab.io%2Fdocker-scanservjs%2F)](https://guillaumedsde.gitlab.io/docker-scanservjs/)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/27a9ea4b0a3f4e04b3b95fcd1086471f)](https://www.codacy.com/manual/guillaumedsde/docker-scanservjs?utm_source=gitlab.com&utm_medium=referral&utm_content=guillaumedsde/docker-scanservjs&utm_campaign=Badge_Grade)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/guillaumedsde/docker-scanservjs)](https://hub.docker.com/r/guillaumedsde/docker-scanservjs)
[![Docker Pulls](https://img.shields.io/docker/pulls/guillaumedsde/docker-scanservjs)](https://hub.docker.com/r/guillaumedsde/docker-scanservjs)
[![GitHub stars](https://img.shields.io/github/stars/guillaumedsde/docker-scanservjs?label=Github%20stars)](https://github.com/guillaumedsde/docker-scanservjs)
[![GitHub watchers](https://img.shields.io/github/watchers/guillaumedsde/docker-scanservjs?label=Github%20Watchers)](https://github.com/guillaumedsde/docker-scanservjs)
[![Docker Stars](https://img.shields.io/docker/stars/guillaumedsde/docker-scanservjs)](https://hub.docker.com/r/guillaumedsde/docker-scanservjs)
[![GitHub](https://img.shields.io/github/license/guillaumedsde/docker-scanservjs)](https://github.com/guillaumedsde/docker-scanservjs/blob/master/LICENSE.md)

Alpine Linux based docker container for scanservjs with all sane-backends in alpine repositories, built for many different architectures.

## ✔️ Features summary

- 🏔️ Alpine Linux small and secure base Docker image
- 🤏 As few Docker layers as possible
- 🛡️ Minimal software dependencies installed
- 🖥️ Built for many platforms

## 🏁 How to Run

### `docker run`

```bash
$ docker run --privileged \
              -p 8080:8080 \
              guillaumedsde/docker-scanservjs:latest
```

### `docker-compose.yml`

```yaml
version: "3.3"
services:
  docker-scanservjs:
    privileged: true
    ports:
      - "8080:8080"
    image: "guillaumedsde/docker-scanservjs:latest"
```

## 🖥️ Supported architectures

This container is built for many hardware architectures (yes, even ppc64le whoever uses that... 😉):

- linux/386
- linux/amd64
- linux/arm/v6
- linux/arm/v7
- linux/arm64
- linux/ppc64le

All you have to do is use a recent version of docker and it will pull the appropriate version of the image [guillaumedsde/docker-scanservjs](https://hub.docker.com/repository/docker/guillaumedsde/docker-scanservjs) from the docker hub.

## 🙏 Credits

A couple of projects really helped me out while developing this container:

- 💽 [sbs20/scanservjs](https://github.com/sbs20/scanservjs) _the_ awesome software
- 🏁 [s6-overlay](https://github.com/just-containers/s6-overlay) A simple, relatively small yet powerful set of init script for managing processes (especially in docker containers)
- 🏔️ [Alpine Linux](https://alpinelinux.org/) an awesome lightweight secure linux distribution used as the base for this container
- 🐋 The [Docker](https://github.com/docker) project (of course)
