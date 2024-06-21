#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --cpus-per-task=1
#SBATCH --mem=128G
#SBATCH --time=02-00:00:00

#####
# USAGE:
# sbatch --job-name=snapatac2_integrate snapatac2_integrate.sh input_tsv outdir_path
#####

# Date
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Configuring env (choose either singularity or conda)
source activate /cellar/users/aklie/opt/miniconda3/envs/scverse-lite-py39
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/opt/miniconda3/lib/
script_path=/cellar/users/aklie/data/datasets/igvf_sc-islet_10X-Multiome/bin/data_annotation/snapatac2/integrate_snapatac2.py

# Inputs
input_tsv=$1
outdir_path=$2
input_h5ad_paths=($(cut -f1 $input_tsv))
sample_ids=($(cut -f2 $input_tsv))

# Echo inputs and number of inputs
echo -e "total inputs: ${#input_h5ad_paths[@]}"
echo -e "input_h5ad_paths: ${input_h5ad_paths[@]}"
echo -e "sample_ids: ${sample_ids[@]}"
echo -e "outdir_path: $outdir_path"

# Make outdir path if it doesn't exist
if [ ! -d $outdir_path ]; then
    mkdir -p $outdir_path
fi 

cmd="python $script_path \
--input_h5ad_paths ${input_h5ad_paths[@]} \
--sample_ids ${sample_ids[@]} \
--outdir_path $outdir_path \
--plot_vars log_n_fragment tsse"
echo -e "Running:\n $cmd\n"
eval $cmd

date