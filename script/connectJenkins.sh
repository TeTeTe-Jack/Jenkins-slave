#!/bin/bash



docker -H=tcp://localhost:$PORT exec -it $name java -jar /root/agent.jar -jnlpUrl $jenkinsUrl/computer/$name/slave-agent.jnlp -secret $secret -workDir $workDir
