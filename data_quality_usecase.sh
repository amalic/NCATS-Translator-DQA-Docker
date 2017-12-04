#!/bin/sh

#docker run -it --name data_quality_python --rm -v ~/docker/kraken/NCATS-Translator-DQA/ncats_translator_dqa:/usr/src/myapp -w /usr/src/myapp python:3 python translator_dqa.py -f "https://fairsharing.org/biodbcore-000663"

docker run -it --name data_quality_python --rm -v ~/NCATS-Translator-DQA/ncats_translator_dqa:/usr/src/myapp -w /usr/src/myapp python:3 python translator_dqa.py -f "https://fairsharing.org/biodbcore-000663"
