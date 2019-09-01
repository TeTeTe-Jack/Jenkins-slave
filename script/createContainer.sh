#!/bin/bash

# set parameters
name=$2
PORT=$3

# check parameters
portTest=`docker -H=tcp://localhost:${PORT} ps 2>&1 >/dev/null`
if test "${porTest}" != '';then
  echo error:${portTest}
  echo ${PORT} is not the port of docker api.
  exit 1
fi

nameTest=`docker -H=tcp://localhost:${PORT} ps -a --format "{{.Names}}" | grep ^${name}$`
if test "${nameTest}" = "${name}";then
  echo ${name} is already exist.
  exit 2
fi

# create a new container
docker -H=tcp://localhost:${PORT} run -it --restart=always --name ${name} --privileged -d jenkins-slave-base /sbin/init

exit 0
