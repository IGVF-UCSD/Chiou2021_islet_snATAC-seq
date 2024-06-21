# Script to run chrombpnet pipeline on mo_EndoC-bH1_ATAC-seq data
script=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/bin/chrombpnet/chrombpnet_contribution_bws.sh

# Reference info
genome=/cellar/users/aklie/data/ref/genomes/hg38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna
chromsizes=/cellar/users/aklie/data/ref/genomes/hg38/GRCh38_EBV.chrom.sizes

# Sample specific info
regions=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/analysis/chrombpnet/2023_07_26/nextflow_EndoC_ATAC_NPB2.mRp.clN.sorted_peaks.narrowPeak

# Fold 0
fold=0
model=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/analysis/chrombpnet/2023_07_26/fold_${fold}/models/chrombpnet_nobias.h5
out_prefix=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/analysis/chrombpnet/2023_07_26/fold_${fold}/contributions/chrombpnet_nobias
mkdir -p /cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/analysis/chrombpnet/2023_07_26/fold_${fold}/contributions
sbatch --job-name=chrombpnet_contribution_bws $script $model $regions $genome $chromsizes $out_prefix
