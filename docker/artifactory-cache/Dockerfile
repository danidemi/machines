FROM debian:8.0

MAINTAINER Daniele Demichelis

RUN apt-get update; apt-get install -y openjdk-7-jre-headless unzip wget

RUN mkdir /artifactory; cd /artifactory; wget http://dl.bintray.com/jfrog/artifactory/artifactory-3.5.0.zip; unzip artifactory-3.5.0.zip

CMD /artifactory/artifactory-3.5.0/bin/artifactory.sh

EXPOSE 8081

# Where jars are placed
VOLUME /artifactory/artifactory-3.5.0/data/filestore 
