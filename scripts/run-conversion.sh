#!/bin/bash

set -euo pipefail

#This script converts h5ad to loom file which is expected input for scenic only pipeline mode

input_path="${1:?Please provide path to h5ad}"
output_path="${2:-conversion_output}"

#Change hard paths to local version if cloning repo
im=/lustre/scratch117/cellgen/cellgeni/simon/grnboost2-testing/github_repo/grnboost2-conversion.sif
script=/lustre/scratch117/cellgen/cellgeni/simon/grnboost2-testing/github_repo/converting-h5ad.R

mkdir -p $output_path

/software/singularity-v3.9.0/bin/singularity exec -B /lustre,/nfs $im \
Rscript $script --input=$input_path --output=$output_path
