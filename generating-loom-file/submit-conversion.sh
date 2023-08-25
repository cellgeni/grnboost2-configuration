#!/bin/bash

set -euo pipefail

script="${1:?Please provide path to converting-h5ad}"
group="${2:?Please provide bsub group}"
input_path="${3:?Please provide path to h5ad}"
output_path="${4:-conversion_output}"

#Change hard paths to local version if cloning repo
im=/nfs/cellgeni/singularity/images/grnboost-anndata2loom-scanpy_v1.7.1-loompy_v3.0.6.sif

mkdir -p $output_path
mkdir -p logs

bsub -n 4 -Rspan[hosts=1] -M 64000 -R"select[mem>64000] rusage[mem=64000]" -G $group -q "long" -o logs/outfile.%J.txt -e logs/errorfile.%J.txt \
  /software/singularity-v3.9.0/bin/singularity exec -B /lustre,/nfs $im python $script -f $input_path -o $output_path 
