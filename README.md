<!--
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
-->

stronghammer builds alpine based docker images.

Usage:

```
export PACKAGE=findutils &&
    export ENTRYPOINT=find &&
    export ORGANIZATION=mydockerorg &&
    export VERSION=0.0.0 &&
    DOCKERHUB_ID=your docker hub id
    DOCKERHUB_PASSWORD= your docker hub password
    docker \
        run \
        --interactive \
        --tty \
        --rm \
        --env PACKAGE \
        --env ENTRYPOINT \
        --env ORGANIZATION \
        --env PROJECT \
        --env VERSION \
        wildwarehouse/stronghammer:1.0.0
```

would create a docker image with findutils installed.  running this image would invoke find.

this will push the image to dockerhub for everyone to enjoy.