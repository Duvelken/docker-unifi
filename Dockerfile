# Base image to use
FROM ubuntu:16.04

MAINTAINER Duvelken

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" \
    | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \

COPY mongodb.service /etc/systemd/system/

RUN systemctl start mongodb && \
    systemctl enable mongodb

# Install Unifi Controller (latest Stable)
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    echo "deb http://www.ubnt.com/downloads/unifi/distros/deb/ubuntu ubuntu ubiquiti" \
    | tee /etc/apt/sources.list.d/100-ubnt.list && \
    apt-get update
    apt-get install unifi

EXPOSE 8443
