# grnboost2-configuration
Repository for storing general use configuration files for grnboost2

There are 3 modes for running grnboost2 in this repo.

The most popular will be `scenic-only.sh` which runs the grnboost2 processes without any preprocessing

The second mode is `single-run.sh` which runs the preprocessing in the pipeline so that the outputs can be inspected manually to see if the filters need to be changed.

Once this has occured the `multi-run.sh` script can be used which runs preprocessing and grnboost2 in the pipeline 

`run-conversion.sh` is used to run `converting-h5ad.R` whcih will alter a h5ad file into a loom file which `scenic-only.sh` expects as input
