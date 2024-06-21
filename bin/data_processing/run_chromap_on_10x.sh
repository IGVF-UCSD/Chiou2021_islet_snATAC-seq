#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=14:00:00

#####
# USAGE:
# sbatch --job-name=Chiou2021_islet_snATAC-seq_run_chromap_on_10x run_chromap_on_10x.sh
#####

# Start time
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Activate the env with chromap
source activate /cellar/users/aklie/opt/miniconda3/envs/pipelines

# Set file paths
input_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/fastq/SRP290255/SRX9409845/
output_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/processed/chromap
sample=nPOD-6004-1
read1=$input_dir/SRR14135828_2.fastq.gz
read2=$input_dir/SRR14135828_4.fastq.gz
barcode=$input_dir/SRR14135828_3.fastq.gz
ref_dir=/cellar/users/aklie/data/ref/genomes/hg38
bc_whitelist=/cellar/users/aklie/data/ref/bc_whitelists/737K-cratac-v1.rc.txt

# Make output directory if doesn't exist
if [ ! -d $output_dir/$sample ]; then
    mkdir -p $output_dir/$sample
fi

# Run the command
cmd="chromap --preset atac \
--drop-repetitive-reads 4 \
-q 0 \
-x $ref_dir/chromap/index \
-r $ref_dir/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna \
-1 $read1 \
-2 $read2 \
-o $output_dir/$sample/aln.bed \
-b $barcode \
--barcode-whitelist $bc_whitelist \
--num-threads 12"

echo -e "Running:\n $cmd\n"
eval $cmd

# End time
date
