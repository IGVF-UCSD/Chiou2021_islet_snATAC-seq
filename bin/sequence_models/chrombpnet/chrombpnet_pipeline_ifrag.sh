#! /bin/bash
#SBATCH --account carter-gpu
#SBATCH --partition carter-gpu
#SBATCH --gpus=1
#SBATCH --output=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --mem=64G
#SBATCH -n 2
#SBATCH -t 14-00:00:00

#####
# INFO:
# Script to run chrombpnet pipeline on single input sample in bam format
#####

#####
# USAGE: sbatch --job-name=${dataset_name}_chrombpnet --error /path/to/err --output /path/to/out chrombpnet_pipeline.sh $coverage $genome $peaks $chromsizes $negatives $fold $bias_model $out_dir
#####

# Set-up env
source activate chrombpnet
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cellar/users/aklie/opt/miniconda3/envs/chrombpnet/lib
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Set up args
genome=/cellar/users/aklie/data/ref/genomes/hg38/hg38.fa
chromsizes=/cellar/users/aklie/data/ref/genomes/hg38/hg38.chrom.sizes

# 
frag=$1
peaks=$2
negatives=$3
fold=$4
bias_model=$5
out_dir=$6

# Run cmd
cmd="chrombpnet pipeline \
    -ifrag $frag \
    -d ATAC \
    -g $genome \
    -c $chromsizes \
    -p $peaks \
    -n $negatives \
    -fl $fold \
    -b $bias_model \
    -o $out_dir"
echo -e $cmd
eval $cmd
