#!/bin/bash

set -euo pipefail

CONFIG=../conf/scenic-only.config

DATA="${1:?Please provide path to data}"
PROJECT="${2:-scenic-only}"
OUTDIR="${3:-scenic-only-results}"

## Need to set nextflow variables in order to correctly run on Sanger FARM Cellular Genetics Informatics Nextflow Installation

export NXF_SINGULARITY_LIBRARYDIR=/nfs/cellgeni/grnboost2-stuff/singularity_folder
export NXF_SINGULARITY_CACHEDIR=/nfs/cellgeni/grnboost2-stuff/cache
export NXF_SINGULARITY_TMPDIR=/nfs/cellgeni/grnboost2-stuff/tmp
export NXF_VER=21.04.3
export XDG_RUNTIME_DIR=/nfs/users/nfs_c/cellgeni-su/xdg_dir

## SCENIC ONLY RUN SCRIPT

nextflow -C $CONFIG                          \
    run vib-singlecell-nf/vsn-pipelines      \
    --ansi-log false                         \
    -resume                                  \
    -w "${PROJECT}_work"                     \
    -entry scenic                            \
    --data.loom.file_paths $DATA             \
    --tools.scenic.filteredLoom $DATA        \
    --global.project_name $PROJECT           \
    --global.outdir $OUTDIR                  \
    --tools.scanpy.filter.outdir $OUTDIR     \
    --tools.scenic.outdir "${OUTDIR}/scenic" \
    --timeline.file "${OUTDIR}/nextflow_reports/execution_timeline.html"  \
    --report.file "${OUTDIR}/nextflow_reports/execution_report.html"      \
    --trace.file "${OUTDIR}/nextflow_reports/execution_trace.txt"         \
    --dag.file "${OUTDIR}/nextflow_reports/pipeline_dag.svg"
