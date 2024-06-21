#!/bin/bash
#SBATCH --partition=carter-compute
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A_%a.out
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=14:00:00
#SBATCH --array=1-4%4

#####
# USAGE:
# sbatch --job-name=Chiou2021_islet_snATAC-seq_run_chromap_on_CB run_chromap_on_CB.sh
#####

# Start time
date
echo -e "Job ID: $SLURM_JOB_ID\n"

# Activate the env with chromap
source activate /cellar/users/aklie/opt/miniconda3/envs/pipelines

# Samples
experiment_accessions=(
    'SRX9409841'
    'SRX9409842'
    'SRX9409843'
    'SRX9409844'
)
sample_ids=(
    'UNOS_AFC2208'
    'UNOS_AFEA331'
    'UNOS_AFEP022'
    'nPOD_6004_CB'
)
fastq_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/fastq/SRP290255
input_dir=$fastq_dir/${experiment_accessions[$SLURM_ARRAY_TASK_ID-1]}
output_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/processed/chromap
sample=${sample_ids[$SLURM_ARRAY_TASK_ID-1]}
read1=$(ls $input_dir/*_R1.fastq.gz)
read2=$(ls $input_dir/*_R2.fastq.gz)
barcode=$(ls $input_dir/*_barcodes.fastq.gz)
ref_dir=/cellar/users/aklie/data/ref/genomes/hg38

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
-b $barcode \
-o $output_dir/$sample/aln.bed \
--num-threads 12"

echo -e "Running:\n $cmd\n"
eval $cmd

# End time
date
