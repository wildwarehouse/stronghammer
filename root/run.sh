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

apk update &&
    apk upgrade &&
    apk add --no-cache docker &&
    rm -rf /var/cache/apk/*