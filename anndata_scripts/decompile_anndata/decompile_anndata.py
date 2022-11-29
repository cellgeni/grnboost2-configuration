import argparse
import json
import numpy as np
import scanpy as sc
from scipy import sparse
import os

def getArgs():
  parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,)
  parser.add_argument('-f','--file', help="the file of the 0.8 AnnData object", required=True)
  parser.add_argument('-uns', action="store_true", default=False, help="will decompile adata.uns")
  parser.add_argument('-raw', action="store_true", default=False, help="will decompile adata.var.raw")
  parser.add_argument('-o','--output', help="the output path for decompiled files (default current directory)", default=os.getcwd())
  args = parser.parse_args()
  return args

args = getArgs()

file = args.file
output = args.output + "/decompiled_h5ad"
adata = sc.read(file)

if args.uns:
  with open(output + '_uns.json','w') as outfile:
    json.dump(dict(adata.uns), outfile)
  print('saved uns to .json')

adata.obs.to_csv(output + '_obs.csv')
adata.var.to_csv(output + '_var.csv')

if args.raw:
  adata.raw.var.to_csv(output + '_raw_var.csv')

print('saved var, raw.var and obs to .csv')

for x in adata.obsm:
  np.save(output + '_obsm_' + x + '.npy', adata.obsm[x])
  print('saved obsm to .npy')

if type(adata.X) != sparse.csr.csr_matrix:
  adata.X = sparse.csr_matrix(adata.X)
  print('converted .X to sparse')
sparse.save_npz(output + '_X.npz', adata.X)
print('saved .X to .npz')

if adata.raw:
  raw_x = adata.raw.X
  if type(raw_x) != sparse.csr.csr_matrix:
    raw_x = sparse.csr_matrix(raw_x)
    print('converted raw.X to sparse')
  sparse.save_npz(output + '_rawX.npz', raw_x)
  print('saved .X to .npz')

print('DONE')
