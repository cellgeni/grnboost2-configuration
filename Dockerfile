FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

COPY conda.yml /tmp/conda.yml

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends build-essential software-properties-common wget 

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH="/opt/conda/condabin:${PATH}"

RUN conda update -n base conda && \
    conda config --add channels conda-forge && \
    conda config --add channels bioconda

RUN conda env update -n base --file /tmp/conda.yml 

RUN conda install -y -n base -c conda-forge r-base="4.1.3"

RUN conda install -y -n base -c conda-forge r-rlang

RUN conda install -y -n base -c conda-forge r-spatstat.utils

ENV PATH="/opt/conda/bin:${PATH}"
