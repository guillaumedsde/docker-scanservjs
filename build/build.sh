#!/bin/sh

VERSION=${VERSION:-"$(git ls-remote https://github.com/sbs20/scanservjs.git HEAD | awk '{ print $1}')"}

if [ "${CI_COMMIT_REF_NAME}" = "master" ]; then
    TAGS=" -t ${CI_REGISTRY_USER}/docker-scanservjs:${VERSION} -t ${CI_REGISTRY_USER}/docker-scanservjs:latest "
else
    # cleanup branch name
    BRANCH="$(echo "${CI_COMMIT_REF_NAME}" | tr / _)"
    # tag image with branch name
    TAGS="-t ${CI_REGISTRY_USER}/docker-scanservjs:${BRANCH}"
fi

# shellcheck disable=SC2086
docker buildx build . \
    --platform="${BUILDX_PLATFORM}" \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="${VERSION}" \
    ${TAGS} \
    --push
