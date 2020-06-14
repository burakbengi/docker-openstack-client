from ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install python3-openstackclient jq && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
