#!/bin/sh

# This file is part of stronghammer.
#
#    stronghammer is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    stronghammer is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with stronghammer .  If not, see <http://www.gnu.org/licenses/>.

( [ ! -z "${PACKAGE}" ] || (echo Alpine Package not specified && exit 65)) &&
    ( [ ! -z "${ENTRYPOINT}" ] || (echo Alpine Entry Point not specified && exit 66)) &&
    ( [ ! -z "${ORGANIZATION}" ] || (echo Docker Organization not specified && exit 67)) &&
    ( [ ! -z "${DOCKERHUB_ID}" ] || (echo DockerHub User ID not specified && exit 68)) &&
    ( [ ! -z "${DOCKERHUB_PASSWORD}" ] || (echo DockerHub Password not specified && exit 69)) &&
    ( [ ! -z "${VERSION}" ] || (echo Docker Version not specified && exit 69)) &&
    cd $(mktemp -d) &&
    (cat > Dockerfile <<EOF
FROM wildwarehouse/alpine:0.0.1
USER root
RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${PACKAGE} && \
    rm -rf /var/cache/apk/*
USER user
ENTRYPOINT [ "${ENTRYPOINT}" ]
CMD [ ]
EOF
    ) &&
    docker build --tag ${ORGANIZATION}/${ENTRYPOINT}:${VERSION} . &&
    (cat <<EOF
{
    "username": "${DOCKERHUB_ID}",
    "password": "${DOCKERHUB_PASSWORD}"
}
EOF
    ) | curl -s -H "Content-Type: application/json" -X POST -d @- https://hub.docker.com/v2/users/login/ | jq -r .token > token.txt &&
    TOKEN=$(cat token.txt) &&
    curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${ORGANIZATION}/${ENTRYPOINT} &&
    docker login --username ${DOCKERHUB_ID} --password ${DOCKERHUB_PASSWORD} &&
    docker push ${ORGANIZATION}/${ENTRYPOINT}:${VERSION}