#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.%a.out
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=14:00:00
#SBATCH --array=1-12%12

#####
# USAGE:
# sbatch --job-name=frags2countBigWig frags2countBigWig.sh
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configure environment
source activate /cellar/users/aklie/opt/miniconda3/envs/chrombpnet

# Directories and files
in_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/integration/atac/fragments
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/insertion_counts
script=/cellar/users/aklie/opt/chrombpnet/chrombpnet/helpers/preprocessing/reads_to_bigwig.py
genome=/cellar/users/aklie/data/ref/genomes/hg38/hg38.fa
chrom_sizes=/cellar/users/aklie/data/ref/genomes/hg38/hg38.chrom.sizes

# TODO: get the list of all frags files (recursive) and select based on the array id
frags_files=($(find $in_dir -name "*bed.gz" | sort))
frags_file=${frags_files[$SLURM_ARRAY_TASK_ID-1]}
celltype=$(basename $frags_file .bed.gz)

# Run the script
cmd="python $script \
--genome $genome \
--input-fragment-file $frags_file \
--chrom-sizes $chrom_sizes \
--output-prefix $out_dir/$celltype \
--data-type ATAC"
echo -e "Running command:\n$cmd"
eval $cmd

date