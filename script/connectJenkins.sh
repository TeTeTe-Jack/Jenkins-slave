#!/bin/bash

name=$2
PORT=$3
secret=$4
workDir=$5
jenkinsURL=$6

# create a file of jenkins slave service
echo java -jar /root/agent.jar -jnlpUrl ${jenkinsURL}computer/${name}/slave-agent.jnlp -secret ${secret} -workDir ${workDir} > jenkins-slave.sh

# get agent.jar
wget ${jenkinsURL}jnlpJars/agent.jar

# copy the file
docker -H=tcp://localhost:${PORT} cp jenkins-slave.sh ${name}:/root/
docker -H=tcp://localhost:${PORT} cp agent.jar ${name}:/root/

# change owner and add +x
docker -H=tcp://localhost:${PORT} exec ${name} chown root:root /root/jenkins-slave.sh
docker -H=tcp://localhost:${PORT} exec ${name} chmod +x /root/jenkins-slave.sh

# start service
docker -H=tcp://localhost:${PORT} exec ${name} sh /root/jenkins-slave.sh

# delete created file
rm -f jenkins-slave.sh

exit 0
