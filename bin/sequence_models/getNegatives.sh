#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=14:00:00

#####
# USAGE:
# sbatch --job-name=getNegatives getNegatives.sh
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configure environment
source activate /cellar/users/aklie/opt/miniconda3/envs/ml4gland

# Ref files
genome=/cellar/users/aklie/data/ref/genomes/hg38/hg38.fa
chrom_sizes=/cellar/users/aklie/data/ref/genomes/hg38/hg38.chrom.sizes

# Data files
input=$1
output=$2

cmd="bpnet negatives \
-i $input \
-f $genome \
-o $output \
-l 0.02 \
-w 2048 \
-v"
echo $cmd
eval $cmd

date