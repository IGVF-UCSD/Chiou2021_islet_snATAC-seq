#!/bin/bash
#SBATCH --partition=carter-gpu
#SBATCH --account=carter-gpu
#SBATCH --gpus=1
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=14-00:00:00

#####
# USAGE:
# sbatch --job-name=chromBPNetLitePipeline chromBPNetLitePipeline.sh /path/to/config.json /path/to/output_dir
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configure environment
source activate /cellar/users/aklie/opt/miniconda3/envs/ml4gland

# params
in_json=$1
out_dir=$2

# Make output directory
mkdir -p $out_dir

cd $out_dir
cmd="chrombpnet pipeline -p $in_json"
echo -e "Running command: $cmd"
eval $cmd

# Date
date