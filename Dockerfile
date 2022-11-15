FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

COPY conda.yml /tmp/conda.yml

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils liblzma-dev libbz2-dev zlib1g libpng-dev libxml2-dev libssl-dev \
    gfortran-7 libglpk-dev libhdf5-dev libcurl4-openssl-dev build-essential software-properties-common wget libfreetype6-dev

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

RUN conda install -y -n base -c bioturing r-seuratdata

#RUN conda install -y -n base -c conda-forge r-seuratdisk

ENV PATH="/opt/conda/bin:${PATH}"

RUN Rscript -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "remotes::install_github('mojaveazure/seurat-disk')"

#RUN Rscript -e "install.packages(c('processx', 'systemfonts',  'ggrepel'), repos = 'http://cran.us.r-project.org')"
#
#RUN Rscript -e "install.packages(c('BiocManager', 'R.utils', 'reticulate'), repos = 'http://cran.us.r-project.org')"
#
#RUN Rscript -e "BiocManager::install(c('Rhtslib', 'LoomExperiment', 'SingleCellExperiment'))"
#
#RUN Rscript -e "remotes::install_github(c('cellgeni/sceasy@v0.0.6', 'satijalab/seurat-data'))"
#
#RUN Rscript -e "install.packages(c('hdf5r','dimRed','png','ggplot2','reticulate','plotly','Matrix','network','leiden', 'Seurat'), repos = 'http://cran.us.r-project.org'))" 
#
#RUN Rscript -e "install.packages('SeuratObject', repos = 'http://cran.us.r-project.org')"
##
#RUN Rscript -e "remotes::install_github('mojaveazure/seurat-disk')"
