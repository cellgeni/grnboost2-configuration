#!/bin/bash

set -euo pipefail

decompile_im=/nfs/cellgeni/singularity/images/anndata_07.sif
recompile_im=/nfs/cellgeni/singularity/images/anndata_08.sif

file="${1:?Provide path to anndata 0.8 h5ad object}"

singularity exec -B /lustre,/nfs $decompile_im \
  python decompile_anndata.py -f $file
singularity exec -B /lustre,/nfs $recompile_im \
  python recompile_anndata.py
