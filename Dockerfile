FROM ubuntu:latest
MAINTAINER arka ghosh <arkaghosh.nb@gmail.com>

#Install Open JDK 8

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update -y

#Install OpenJDK 8
RUN apt-get -y install openjdk-8-jdk

#Set PATH and HOME
ENV JAVA_HOME "/usr/lib/jvm/java-8-openjdk-amd64"
ENV PATH $JAVA_HOME/bin:$PATH

#Add the library jar file to the image
ADD build/libs/onlinelibrary.jar onlinelibrary.jar
CMD java -jar onlinelibrary.jar
