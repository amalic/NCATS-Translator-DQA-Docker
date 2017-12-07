# NCATS Translator
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

---

Dockerizing the NCATS Translator for Data Quality Analysis



The purpose of this project is to provide automation of the [NCATS Translator](https://github.com/pedrohserrano/NCATS-Translator-DQA) Tool in order to escalate on more general Data Quality assessment.

## Prerequisites

Installing [Docker](https://docs.docker.com/) for [Mac](https://docs.docker.com/docker-for-mac/install/) and [Windows](https://docs.docker.com/docker-for-windows/install/download-docker-for-windows)


## Usage

##### Clone the repo

        git clone https://github.com/amalic/NCATS-Translator-DQA-Docker.git && \
        cd NCATS-Translator-DQA-Docker

##### Building the Docker image  

        docker build -t translator_dqa .

##### Runing a Docker container  
---

Options: 
##### 1. Run translator and show help message

        docker run -it --rm -p 7200:7200  \
        -v ~/NCATS-Translator-DQA-Docker/data/Input:/root/NCATS-Translator-DQA/Input/ \
        -v ~/NCATS-Translator-DQA-Docker/data/Output:/root/NCATS-Translator-DQA/Output/ \
        translator_dqa -h

##### 2. Run translator on a url   

        docker run -it --rm -p 7200:7200  \
        -v ~/NCATS-Translator-DQA-Docker/data/Input:/root/NCATS-Translator-DQA/Input/ \
        -v ~/NCATS-Translator-DQA-Docker/data/Output:/root/NCATS-Translator-DQA/Output/ \
        translator_dqa -f https://biosharing.org/biodbcore-000015

##### 3. Run translator on a local file

        docker run -it --rm -p 7200:7200 \
        -v ~/NCATS-Translator-DQA-Docker/data/Input:/root/NCATS-Translator-DQA/Input/ \
        -v ~/NCATS-Translator-DQA-Docker/data/Output:/root/NCATS-Translator-DQA/Output/ \
        translator_dqa -d /root/NCATS-Translator-DQA/Input/kegg-drug.ttl

##### 4. Build the container and keep it running  

        docker run -it -p 7200:7200 \
        -v ~/NCATS-Translator-DQA-Docker/data/Input:/root/NCATS-Translator-DQA/Input/ \
        -v ~/NCATS-Translator-DQA-Docker/data/Output:/root/NCATS-Translator-DQA/Output/ \
        --name=dqa_box translator_dqa

##### 5. Build the container and run bash

        docker run -it -p 7200:7200 \
        -v ~/NCATS-Translator-DQA-Docker/data/Input:/root/NCATS-Translator-DQA/Input/ \
        -v ~/NCATS-Translator-DQA-Docker/data/Output:/root/NCATS-Translator-DQA/Output/ \
        --name=dqa_box --entrypoint /bin/bash translator_dqa 

(exit the container `exit`)

##### 5.1 Run again an existing container   

        docker start -ai dqa_box

##### 5.2 Runing inside the container

        ./translator_dqa.py -d /root/NCATS-Translator-DQA/Input/animalqtldb.ttl

go to [http://localhost:7200/](http://localhost:7200/)

## Licence

The MIT License (MIT) 2017

## Acknowledgments

* [RDFUnit](http://aksw.org/Projects/RDFUnit.html)
* [FAIRsharing.org](http://FAIRsharing.org)