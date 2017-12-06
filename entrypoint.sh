#!/bin/bash
service graphdb start

echo waiting for graphdb ...
while ! echo exit | nc localhost 7200; do sleep 2; done
echo graphdb finished

echo executing translator_dqa.py $@
./translator_dqa.py $@
echo data quality assesment finished