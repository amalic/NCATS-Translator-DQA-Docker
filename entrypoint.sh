#!/bin/bash
service graphdb start

python translator_dqa.py $@

