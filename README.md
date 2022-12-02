# General Information
Repository for storing general use configuration files for grnboost2

These scripts execute the vsn-pipelines nextflow pipeline: https://vsn-pipelines.readthedocs.io

Some slight alterations have been made to the repository for Sanger specific analysis, if you want to run this pipeline yourself then do:
`git clone git@github.com:cellgeni/vsn-pipelines.git`

Next, you will need to alter the script to point to the cloned repository `main.nf` i.e:

`nextflow run -C /path/to/config run /path/to/cloned/repo/main.nf`

## Recompiling Anndata

If your `h5ad` file was built under anndata 0.8+, then it will not be able to be converted to loom with `sceasy`. To fix this, Batuhan Cakir made 2 scripts `decompile_anndata.py` and `recompile_anndata.py`. Simon Murray (using Martin Prete's template Dockerfile) made Dockerfiles and singularity images for these scripts. 

To recompile your anndata object, do `/path/to/decompile_recompile.sh /path/to/anndata.h5ad`

This will output a file called `recompiled_07.h5ad` which can be used as the input to the SCeasy conversion.

## Converting Anndata to Loom 

To run the `scenic-only.sh` mode, a Loom file is needed as input. To convert your anndata object to loom, run the `submit-conversion.sh /path/to/converting-h5ad.py bsub-group /path/to/input/anndata.h5ad /path/to/output/directory`

This will output a loom file (`converted_h5ad.loom`). The loom file can be used an input to the scenic-only mode.

## Running the Pipeline

There are 3 modes for running grnboost2 in this repo.

The most popular will be `scenic-only.sh` which runs the grnboost2 processes without any preprocessing

The second mode is `single-run.sh` which runs the preprocessing in the pipeline so that the outputs can be inspected manually to see if the filters need to be changed.

Once this has occured the `multi-run.sh` script can be used which runs preprocessing and grnboost2 in the pipeline 
