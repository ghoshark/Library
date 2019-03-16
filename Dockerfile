# Pull Base Image
FROM ubuntu:latest
MAINTAINER Arka Ghosh "arka.ghosh@se.com"

WORKDIR .

# Install Java 8
RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install oracle-java8-installer -y

ENV JAVA_HOME "/usr/lib/jvm/java-8-oracle" 

ADD build/libs/onlinelibrary.jar onlinelibrary.jar
CMD java -jar onlinelibrary.jar 
