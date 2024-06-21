#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A_%a.out
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=14-00:00:00
#SBATCH --array=1-5%5

#####
# USAGE:
# sbatch --job-name=Chiou2021_islet_snATAC-seq_snapatac2_process snapatac2_process.sh
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configuring env (choose either singularity or conda)
source activate /cellar/users/aklie/opt/miniconda3/envs/scverse-lite-py39
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/opt/miniconda3/lib/
params_file=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/sample_annotation/config/snapatac2_single_sample.yaml

# Inputs
input_tsv=$1
outdir_path=$2
input_frag_paths=($(cut -f1 $input_tsv))
sample_ids=($(cut -f2 $input_tsv))
input_frag_path=${input_frag_paths[$SLURM_ARRAY_TASK_ID-1]}
sample_id=${sample_ids[$SLURM_ARRAY_TASK_ID-1]}
outdir_path=$2/${sample_id}/atac/snapatac2

# Echo inputs and number of inputs
echo -e "total inputs: ${#input_frag_paths[@]}"
echo -e "input_frag_path: $input_frag_path"
echo -e "sample_id: $sample_id"
echo -e "outdir_path: $outdir_path"
echo -e "params_file: $params_file"
echo -e "annot_path: $annot_path\n"

# If output dir does not exist, create it
if [ ! -d $outdir_path ]; then
    mkdir -p $outdir_path
fi

# Command
cmd="cellcommander recipes \
--input_paths $input_frag_path \
--outdir_path $outdir_path \
--sample_name $sample_id \
--method snapatac2 \
--mode single-sample \
--params_path $params_file"
echo -e "Running command:\n$cmd\n"
eval $cmd

date
