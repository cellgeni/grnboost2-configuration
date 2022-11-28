#!/bin/bash

set -euo pipefail

#This script converts h5ad to loom file which is expected input for scenic only pipeline mode

script="${1:?Please provide path to converting-h5ad.R}"
input_path="${2:?Please provide path to h5ad}"
output_path="${3:-conversion_output}"

#Change hard paths to local version if cloning repo
im=/nfs/cellgeni/singularity/images/grnboost.sif

mkdir -p $output_path

/software/singularity-v3.9.0/bin/singularity exec -B /lustre,/nfs $im \
Rscript $script --input=$input_path --output=$output_path
