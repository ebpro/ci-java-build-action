#!/bin/bash
export MAVEN_IMAGE=brunoe/maven:3.8.6-eclipse-temurin-17
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker run \
          --env GITHUBLOGIN=$GITHUBLOGIN \
          --env GITHUBPASSWORD=$GITHUBPASSWORD \
          --mount type=bind,source=${HOME}/.m2,target=/var/maven/.m2 \
          --mount type=bind,source=${HOME}/.ssh,target=/home/user/.ssh \
          --mount type=bind,source=${HOME}/.gitconfig,target=/home/user/.gitconfig,readonly \
          --mount type=bind,source="$(pwd)",target=/usr/src/mymaven \
          --workdir /usr/src/mymaven \
          --rm \
          --env PUID=`id -u` -e PGID=`id -g` \
          --env MAVEN_CONFIG=/var/maven/.m2 \
          $MAVEN_IMAGE \
          runuser --user user --group user -- mvn -B -e -T 1C -Duser.home=/var/maven --settings ${SCRIPT_DIR}/ci-settings.xml "$@"
