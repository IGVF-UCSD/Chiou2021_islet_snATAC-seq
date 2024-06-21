#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_processing/slurm_logs/%x.%A_%a.out
#SBATCH --error=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/bin/data_processing/slurm_logs/%x.%A_%a.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=14:00:00
#SBATCH --array=1-5%5

#####
# USAGE:
# sbatch --job-name=Zhu2023_sc-islet_snATAC-seq_run_cellranger-atac SLURM_ARRAY_run_cellranger-atac.sh
#####

# Start time
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Env
source /cellar/users/aklie/.bashrc

# Set file paths
fastq_dir=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/fastq/04Jul23
output_dir=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger

# Samples
experiment_accessions=(
    'SRX15207297' 
    'SRX15207298' 
    'SRX15207299' 
    'SRX15207300'
    'SRX15207301'
)
sample_ids=(
    'MM129' 
    'MM157' 
    'MM166' 
    'MM168' 
    'MM290'
)
input_dir=$fastq_dir/${experiment_accessions[$SLURM_ARRAY_TASK_ID-1]}
sample=${sample_ids[$SLURM_ARRAY_TASK_ID-1]}

# Go to output directory
cd $output_dir

# Run the command
cmd="cellranger-atac count \
--id=$sample \
--reference=/cellar/users/aklie/opt/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
--fastqs=$input_dir \
--localcores=12"
echo -e "Running:\n $cmd\n"
eval $cmd

# End time
date
