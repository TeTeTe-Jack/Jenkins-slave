#!/bin/bash

name=$2
PORT=$3
secret=$4
workDir=$5
jenkinsURL=$6

# create a file of jenkins slave service
echo java -jar /root/agent.jar -jnlpUrl $jenkinsUrl/computer/$name/slave-agent.jnlp -secret $secret -workDir $workDir > jenkins-slave.sh

# copy the file
docker -H=tcp://localhost:$PORT cp jenkins-slave.sh $name:/root/

# change owner and add +x
docker -H=tcp://localhost:$PORT exec -it $name chown root:root /root/jenkins-slave.sh
docker -H=tcp://localhost:$PORT exec -it $name chmod +x /root/jenkins-slave.sh

# start service
docker -H=tcp://localhost:$PORT exec -it $name sh /root/jenkins-slave.sh

# delete created file
rm -f jenkins-slave.sh

exit 0
