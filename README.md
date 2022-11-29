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

To run the `scenic-only.sh` mode, a Loom file is needed as input. To convert your anndata object to loom, run the `submit-conversion.sh /path/to/converting-h5ad.R bsub-group /path/to/input/anndata.h5ad /path/to/output/directory`

This will output a seurat object (`seurat.rds`) and a loom file (`converted_h5ad.loom`). The loom file can be used an input to thescenic-only mode. Please note, the Dockerfile for the conversion uses the latest version of packages which may not be the same as the ones our image compiled with (`/nfs/cellgeni/singularity/images/grnboost.sif`). Here is the list of our packages and version in our image:

```
R version 4.0.4 (2021-02-15)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 20.04.3 LTS

Matrix products: default
BLAS/LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.8.so

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=C             
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] sceasy_0.0.6          reticulate_1.18       SeuratDisk_0.0.0.9020
[4] SeuratObject_4.0.0    Seurat_4.0.1         

loaded via a namespace (and not attached):
  [1] nlme_3.1-152          matrixStats_0.58.0    spatstat.sparse_2.0-0
  [4] bit64_4.0.5           RcppAnnoy_0.0.18      RColorBrewer_1.1-2   
  [7] httr_1.4.2            sctransform_0.3.2     tools_4.0.4          
 [10] utf8_1.2.1            R6_2.5.0              irlba_2.3.3          
 [13] rpart_4.1-15          KernSmooth_2.23-18    uwot_0.1.10          
 [16] mgcv_1.8-33           lazyeval_0.2.2        colorspace_2.0-0     
 [19] withr_2.4.1           tidyselect_1.1.0      gridExtra_2.3        
 [22] bit_4.0.4             compiler_4.0.4        cli_2.3.1            
 [25] hdf5r_1.3.3           plotly_4.9.3          scales_1.1.1         
 [28] lmtest_0.9-38         spatstat.data_2.1-0   ggridges_0.5.3       
 [31] pbapply_1.4-3         goftest_1.2-2         stringr_1.4.0        
 [34] digest_0.6.27         spatstat.utils_2.1-0  pkgconfig_2.0.3      
 [37] htmltools_0.5.1.1     parallelly_1.24.0     fastmap_1.1.0        
 [40] htmlwidgets_1.5.3     rlang_0.4.10          shiny_1.6.0          
 [43] generics_0.1.0        zoo_1.8-9             jsonlite_1.7.2       
 [46] ica_1.0-2             dplyr_1.0.5           magrittr_2.0.1       
 [49] patchwork_1.1.1       Matrix_1.3-2          Rcpp_1.0.6           
 [52] munsell_0.5.0         fansi_0.4.2           abind_1.4-5          
 [55] lifecycle_1.0.0       stringi_1.5.3         MASS_7.3-53          
 [58] Rtsne_0.15            plyr_1.8.6            grid_4.0.4           
 [61] parallel_4.0.4        listenv_0.8.0         promises_1.2.0.1     
 [64] ggrepel_0.9.1         crayon_1.4.1          miniUI_0.1.1.1       
 [67] deldir_0.2-10         lattice_0.20-41       cowplot_1.1.1        
 [70] splines_4.0.4         tensor_1.5            pillar_1.5.1         
 [73] igraph_1.2.6          spatstat.geom_2.0-1   future.apply_1.7.0   
 [76] reshape2_1.4.4        codetools_0.2-18      leiden_0.3.7         
 [79] glue_1.4.2            data.table_1.14.0     vctrs_0.3.7          
 [82] png_0.1-7             httpuv_1.5.5          gtable_0.3.0         
 [85] RANN_2.6.1            purrr_0.3.4           spatstat.core_2.0-0  
 [88] polyclip_1.10-0       tidyr_1.1.3           assertthat_0.2.1     
 [91] scattermore_0.7       future_1.21.0         ggplot2_3.3.3        
 [94] mime_0.10             xtable_1.8-4          later_1.1.0.1        
 [97] survival_3.2-7        viridisLite_0.3.0     tibble_3.1.0         
[100] cluster_2.1.0         globals_0.14.0        fitdistrplus_1.1-3   
[103] ellipsis_0.3.1        ROCR_1.0-11
```

## Running the Pipeline

There are 3 modes for running grnboost2 in this repo.

The most popular will be `scenic-only.sh` which runs the grnboost2 processes without any preprocessing

The second mode is `single-run.sh` which runs the preprocessing in the pipeline so that the outputs can be inspected manually to see if the filters need to be changed.

Once this has occured the `multi-run.sh` script can be used which runs preprocessing and grnboost2 in the pipeline 
