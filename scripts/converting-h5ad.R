library(sceasy)
library(Seurat)
theargs <- R.utils::commandArgs(asValues=TRUE)
input_h5ad <- theargs$input
output_path <- theargs$output
#Need to Adjust sce2loom function from sceasy to have different attribute names
sce2loom <- function(obj, outFile, main_layer = NULL, drop_single_values = TRUE, ...) {
  if (!requireNamespace("LoomExperiment")) {
    stop("This function requires the 'LoomExperiment' package.")
  }
  scle <- LoomExperiment::SingleCellLoomExperiment(obj)

  if (!is.null(outFile)) {
    LoomExperiment::export(
      scle, outFile,
      matrix = ifelse(!is.null(main_layer) && main_layer %in% SummarizedExperiment::assayNames(scle), main_layer, SummarizedExperiment::assayNames(scle)[1]),
      colnames_attr = "CellID", rownames_attr = "Gene"
    )
  }

  scle
}
convertFormat(input_h5ad, from="anndata", to="seurat", outFile=paste(output_path, 'seurat.rds', sep='/'))
srat <- readRDS(paste(output_path, 'seurat.rds', sep='/'))
convertFormat(srat, from="seurat", to="sce", outFile=paste(output_path, 'SCE.rds', sep='/'))
sce <- readRDS(paste(output_path, 'SCE.rds', sep='/'))
sce2loom(sce, paste(output_path, 'converted_h5ad.loom', sep='/'))
