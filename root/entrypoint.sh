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

while [ ${#} -gt 0 ]
do
    case ${1} in
        --package)
            PACKAGE=${2} &&
                shift 2
        ;;
        --entrypoint)
            ENTRYPOINT=${2} &&
                shift 2
        ;;
        --organization)
            ORGANIZATION=${2} &&
                shift 2
        ;;
        --project)
            PROJECT=${2} &&
                shift 2
        ;;
        --version)
            VERSION=${2} &&
                shift 2
        ;;
        *)
            echo Unknown Option ${@} &&
                exit 64
        ;;
    esac
done &&
    ( [ ! -z "${PACKAGE}" ] || (echo Alpine Package not specified && exit 65)) &&
    ( [ ! -z "${ENTRYPOINT}" ] || (echo Alpine Entry Point not specified && exit 66)) &&
    ( [ ! -z "${ORGANIZATION}" ] || (echo Docker Organization not specified && exit 67)) &&
    ( [ ! -z "${PROJECT}" ] || (echo Docker Project not specified && exit 68)) &&
    cd $(mktemp -d) &&
    (cat > Dockerfile <<EOF
FROM wildwarehouse/alpine:0.0.1
RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${ALPINE_PACKAGE} && \
    rm -rf /var/cache/apk/*
ENTRYPOINT ["${ALPINE_ENTRYPOINT}"]
CMD []
EOF
    ) &&
    docker build --tag ${DOCKER_ORGANIZATION}/${DOCKER_PROJECT}:${DOCKER_VERSION} .
    