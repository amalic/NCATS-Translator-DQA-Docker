# NCATS Translator
[![Python](https://img.shields.io/pypi/pyversions/Django.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

---

Dockerizing the NCATS Translator for Data Quality Analysis



The purpose of this project is to provide automation of the [NCATS Translator](https://github.com/pedrohserrano/NCATS-Translator-DQA) Tool in order to escalate on more general Data Quality assessment.

## Prerequisites

Installing [Docker](https://docs.docker.com/) for [Mac](https://docs.docker.com/docker-for-mac/install/) and [Windows](https://docs.docker.com/docker-for-windows/install/download-docker-for-windows)


## Usage

Clone the repo

        git clone https://github.com/pedrohserrano/NCATS-Translator-DQA

Building the Docker image  

        docker build -t translator_dqa .

Runing a Docker container  

        docker run -it --rm -p 7200:7200  -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ translator_dqa -h


#### Run translator on a url   

        docker run -it --rm -p 7200:7200  \
        -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ \
        -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ \
        translator_dqa -f https://biosharing.org/biodbcore-000015

#### Run translator on a local file

        docker run -it --rm -p 7200:7200 \
        -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ \
        -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ \
        translator_dqa -d /root/NCATS-Translator-DQA/Input/kegg-drug.ttl

#### Build the container and keep it running  

        docker run -it -p 7200:7200 \
        -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ \
        -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ \
        --name=dqa_box translator_dqa

- Maintain with bash)
`docker run -it -p 7200:7200 -v ~/data/DQA-input/:/root/NCATS-Translator-DQA/Input/ -v ~/data/DQA-output:/root/NCATS-Translator-DQA/Output/ --name=dqa_box --entrypoint /bin/bash translator_dqa` 
(levanta el contenedor con un entrypoint) out of the container `exit`

3. Enter existing container   
`docker start -ai dqa_box`

- Runing inside the container
`./translator_dqa.py -d /root/NCATS-Translator-DQA/Input/animalqtldb.ttl`

go to

        http://localhost:7200/

## Licence

## Acknowledgments

* [RDFUnit](http://aksw.org/Projects/RDFUnit.html)
* [FAIRsharing.org](http://FAIRsharing.org)