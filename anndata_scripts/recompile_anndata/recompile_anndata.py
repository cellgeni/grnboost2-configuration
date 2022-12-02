import argparse
import json
import os
import anndata as ad
import numpy as np
import pandas as pd
import scanpy as sc
from scipy import sparse


def getArgs():
  parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,)
  parser.add_argument('-f','--file', help="the file of the 0.8 AnnData object", default="decompiled_h5ad")
  parser.add_argument('-uns', action="store_true", default=False, help="will recompile adata.uns")
  parser.add_argument('-raw', action="store_true", default=False, help="will recompile adata.var.raw")
  args = parser.parse_args()
  return args


args = getArgs()

file_base = args.file

if args.uns:
  uns = json.load(open(file_base + '_uns.json'))
  print('loaded uns')

obs = pd.read_csv(file_base + '_obs.csv', index_col=0)
var = pd.read_csv(file_base + '_var.csv', index_col=0)
if args.raw:
  rawvar = pd.read_csv(file_base + '_raw_var.csv', index_col=0)

print('loaded obs and var')

X = sparse.load_npz(file_base + '_X.npz')
print('loaded .X')

if args.uns:
  adata = ad.AnnData(X, var=var, obs=obs, uns=uns)
else:
  adata = ad.AnnData(X, var=var, obs=obs)
print('initialized AnnData object')

if os.path.exists(file_base + '_rawX.npz'):
  rawX = sparse.load_npz(file_base + '_rawX.npz')
  adata.raw = ad.AnnData(rawX, var=rawvar, obs=obs)
  print('loaded raw layer')

for e in os.listdir('./'):
  if e.startswith(file_base + '_obsm_'):
    k = e.replace(file_base + '_obsm_','').replace('.npy','')
    o = np.load(e)
    adata.obsm[k] = o
    print('added embeddings to obsm')

adata.write(filename='recompiled_07.h5ad', compression='gzip')
print('saved .h5ad')
print('DONE')
