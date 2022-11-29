FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CONDA_PATH=/opt/conda
ENV PATH="${CONDA_PATH}/bin:${PATH}"

RUN apt-get update --yes                                       && \
    apt-get install --yes --no-install-recommends                 \
      bzip2 ca-certificates fonts-liberation locales wget vim     \
      build-essential                                          && \
    apt-get clean                                              && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p "${CONDA_PATH}"                   && \
    rm Miniconda3-latest-Linux-x86_64.sh

COPY environment_ad08.yml /tmp/conda.yml

RUN . "${CONDA_PATH}/etc/profile.d/conda.sh"             && \
    conda activate                                       && \
    conda env update -n base --file /tmp/conda.yml
