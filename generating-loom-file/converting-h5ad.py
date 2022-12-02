#!/bin/python3

import loompy as lp
import scanpy as sc
import argparse, os

def getArgs():
  parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,)
  parser.add_argument('-f','--file', help="Path to h5ad file to be converted", required=True)
  parser.add_argument('-o','--output', help="Output path for loom file (default current directory)", default=os.getcwd())
  args = parser.parse_args()
  return args

args = getArgs()

file = args.file
output = args.output + "/converted_h5ad.loom"

adata = sc.read_h5ad(file)
df_row_metadata = adata.var # A pandas DataFrame holding row metadata
df_col_metadata = adata.obs # A pandas DataFrame holding column metadata
data = adata.X.T # Transposed expression matrix for LOOM conversion
df_row_metadata["Gene"] = df_row_metadata.index #Add Gene column for LOOM conversion
df_col_metadata["CellID"] = df_col_metadata.index #Add CellID column for LOOM conversion
lp.create(output, data, df_row_metadata.to_dict("list"), df_col_metadata.to_dict("list"))
