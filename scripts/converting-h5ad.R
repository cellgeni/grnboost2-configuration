library(sceasy)
library(Seurat)
library(SeuratDisk)
theargs <- R.utils::commandArgs(asValues=TRUE)
input_h5ad <- theargs$input
output_path <- theargs$output
convertFormat(input_h5ad, from="anndata", to="seurat", outFile=paste(output_path, 'converted_h5ad.rds', sep='/'))
srat <- readRDS(paste(output_path, 'converted_h5ad.rds', sep='/'))
lfile <- as.loom(srat, filename = paste(output_path, 'converted_h5ad.loom', sep='/'))
lfile$close_all()
