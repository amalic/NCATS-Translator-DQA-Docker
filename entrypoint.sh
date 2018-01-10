#!/bin/bash
service graphdb start

echo waiting for graphdb ...
while ! echo exit | nc localhost 7200; do sleep 2; done
echo graphdb started

export MAVEN_OPTS="-Xmx8G -XX:MaxPermSize=128m" 
echo Maven options set to $MAVEN_OPTS

echo executing translator_dqa.py $@
./translator_dqa.py $@
echo data quality assesment finished
