#!/bin/bash

# set parameters
name=$2
IP=$3
PORT=$4

# check parameters
portTest=`docker -H=tcp://localhost:$PORT ps 2>&1 >/dev/null`
if test "$porTest" != '';then
  echo error:$portTest
  echo $PORT is not the port of docker api.
  exit 1
fi

nameTest=`docker -H=tcp://localhost:$PORT ps -a -f name=$name | grep -e \s*${name}$ 2>1& >/dev/null`
if test "$nameTest" != '';then
  echo $name is already exist.
  exit 2
fi

pingTest=`ping -c 1 $IP| grep loss`
if test "$pingTest" = '1 packets transmitted, 1 received, 0% packet loss, time 0ms';then
  echo $IP is already exist.
  exit 3
fi

# create a new container
docker -H=tcp://localhost:$PORT run -it --restart=always --name $name --ip=$IP --privileged -d jenkins-slave-base /sbin/init

exit 0
