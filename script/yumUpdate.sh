#/bin/bash

name=$2
port=$3
docker -H=tcp://localhost:$port exec -it $name yum update -y

exit 0

