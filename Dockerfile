FROM python:3.6

LABEL maintainer "Alexander Malic <alexander.malic@maastrichtuniverstity.nl>" \
      maintainer "Pedro Hernandez <p.hernandezserrano@maastrichtuniverstity.nl>"

ADD graphdb /etc/init.d/

ENV PYTHONPATH /root/NCATS-Translator-DQA

RUN cd && \
    echo 'deb http://http.debian.net/debian jessie-backports main' >> /etc/apt/sources.list && \
    apt update && \
    apt install git -y && \
    apt install maven -y && \
    apt install nano -y && \
    apt install netcat -y && \
    pip3 install requests lxml pandas rdflib && \
    apt install -t jessie-backports openjdk-8-jdk -y && \
    update-java-alternatives --set java-1.8.0-openjdk-amd64 && \
    rm /usr/lib/jvm/default-java && ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64 /usr/lib/jvm/default-java && \
    export JAVA_HOME=/usr/lib/jvm/default-java && \
    git clone https://github.com/pedrohserrano/NCATS-Translator-DQA && \
    git clone https://github.com/AKSW/RDFUnit.git && \
    cd RDFUnit && mvn -pl rdfunit-validate -am clean install -Dmaven.test.skip=true -Dmaven.javadoc.skip=true -Dgpg.skip=true -Dsource.skip=true && \
    cd && wget http://go.pardot.com/e/45622/7a-graphdb-free-8-3-1-dist-zip/4yxf7s/1139804593 -O graphdb-free-8.3.1-dist.zip && \
    unzip graphdb-free-8.3.1-dist.zip && \
    cd NCATS-Translator-DQA/ncats_translator_dqa && \
    chmod +x /etc/init.d/graphdb && \
    chmod +x ./translator_dqa.py

WORKDIR /root/NCATS-Translator-DQA/ncats_translator_dqa

COPY entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 7200
