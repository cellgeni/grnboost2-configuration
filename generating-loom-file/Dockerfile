ARG ubuntu_version=20.04

FROM ubuntu:$ubuntu_version

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y cmake 

RUN set -xe && apt-get -y update \
    && apt-get -y install python3.8 python3-dev python3-pip python-is-python3

RUN pip3 install --upgrade pip \
    && pip3 install --upgrade --no-cache scanpy==1.7.1 loompy==3.0.6 argparse
