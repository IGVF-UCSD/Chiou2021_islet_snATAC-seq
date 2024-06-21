#! /bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --mem=64G
#SBATCH -n 4
#SBATCH -t 14-00:00:00

#####
# INFO:
# Script to run 
#####

#####
# USAGE: sbatch --job-name=prep_nonpeaks chrombpnet_prep_nonpeaks.sh <peaks> <fold> <out_dir>
#####
date
echo -e "Job ID: $SLURM_JOB_ID\n"

source activate chrombpnet
genome=/cellar/users/aklie/data/ref/genomes/hg38/hg38.fa
chromsizes=/cellar/users/aklie/data/ref/genomes/hg38/hg38.chrom.sizes
blacklist=/cellar/users/aklie/data/ref/genomes/hg38/blacklist/blacklist.bed.gz

peaks=$1
fold=$2
out_dir=$3

cmd="chrombpnet prep nonpeaks \
    -g $genome \
    -p $peaks \
    -c $chromsizes \
    -fl $fold \
    -br $blacklist \
    -o $out_dir"
echo -e $cmd
eval $cmd

date