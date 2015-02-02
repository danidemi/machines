Just run a debian container

	$ docker run -ti debian:8.0 bash
	$ apt-get update

Install java

	$ apt-get install -y openjdk-7-jre-headless

Install things

	$ apt-get install -y unzip wget

Prepare artifactory

	$ mkdir /artifactory
	$ cd /artifactory
	$ wget http://dl.bintray.com/jfrog/artifactory/artifactory-3.5.0.zip
	$ unzip artifactory-3.5.0.zip

Start it

	$ /artifactory/artifactory-3.5.0/bin

Browse it

	http://<172.17.0.2>:8081

To generate the image

	docker build -t "danidemi/artifactory-cache:3.5"

Run it with

	docker run --rm --name="artifactorycache" -p 8081:8081 danidemi/artifactory-cache:3.5

Artifactory stores things here

	/artifactory/artifactory-3.5.0/data/filestore 
