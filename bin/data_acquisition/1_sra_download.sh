#! /bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/data_acquisition/slurm_logs/%x.%A.out
#SBATCH --mem=100G
#SBATCH -n 64
#SBATCH -t 14-00:00:00

# USAGE: sbatch --job-name=Chiou2021_islet_snATAC-seq_fastq-dump 1_sra_download.sh

python 1_sra_download.py