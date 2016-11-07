# Base image to use
FROM ubuntu:16.04

MAINTAINER Duvelken

# Install MongoDB
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    sudo apt-get update && \
    sudo apt-get install -y mongodb-org && \

COPY mongodb.service /etc/systemd/system/

RUN sudo systemctl start mongodb && \
    sudo systemctl enable mongodb

# Install Unifi Controller (latest Stable)
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    echo "deb http://www.ubnt.com/downloads/unifi/distros/deb/ubuntu ubuntu ubiquiti" \
    | sudo tee /etc/apt/sources.list.d/100-ubnt.list && \
    sudo apt-get update
    sudo apt-get install unifi

EXPOSE 8443
