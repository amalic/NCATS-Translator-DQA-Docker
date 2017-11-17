#!/bin/bash
service graphdb start

echo waiting for graphdb
while ! echo exit | nc localhost 7200; do sleep 1; done
echo graphdb is running now

echo executing translator_dqa.py $@
python translator_dqa.py $@
echo finished
