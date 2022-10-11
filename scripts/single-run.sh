#!/bin/bash

set -euo pipefail

CONFIG=../single-run.config

DATA="${1:?Please provide path to data}"
PROJECT="${2:-single-run}"
OUTDIR="${3:-single-run-results}"

## Need to set nextflow variables in order to correctly run on Sanger FARM Cellular Genetics Informatics Nextflow Installation

export NXF_SINGULARITY_LIBRARYDIR=/nfs/cellgeni/grnboost2-stuff/singularity_folder
export NXF_SINGULARITY_CACHEDIR=/nfs/cellgeni/grnboost2-stuff/cache
export NXF_SINGULARITY_TMPDIR=/nfs/cellgeni/grnboost2-stuff/tmp
export NXF_VER=21.04.3
export XDG_RUNTIME_DIR=/nfs/users/nfs_c/cellgeni-su/xdg_dir

## SINGLE RUN SCRIPT

nextflow -C $CONFIG                          \
    run vib-singlecell-nf/vsn-pipelines      \
    --ansi-log false                         \
    -resume                                  \
    -w "${PROJECT}_work"                     \
    -entry single_sample                     \
    --data.tenx.cellranger_mex $DATA         \
    --global.project_name $PROJECT           \
    --global.outdir $OUTDIR                  \
    --tools.scanpy.filter.outdir $OUTDIR     \
    --tools.scenic.outdir "${OUTDIR}/scenic" \
    --timeline.file "${OUTDIR}/nextflow_reports/execution_timeline.html"  \
    --report.file "${OUTDIR}/nextflow_reports/execution_report.html"      \
    --trace.file "${OUTDIR}/nextflow_reports/execution_trace.txt"         \
    --dag.file "${OUTDIR}/nextflow_reports/pipeline_dag.svg"
