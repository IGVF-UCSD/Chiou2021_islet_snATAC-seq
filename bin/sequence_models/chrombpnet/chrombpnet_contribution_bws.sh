#! /bin/bash
#SBATCH --account carter-gpu
#SBATCH --partition carter-gpu
#SBATCH --gpus=1
#SBATCH --output=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/bin/slurm_logs/%x.%A.out
#SBATCH --error=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/bin/slurm_logs/%x.%A.err
#SBATCH --mem=32G
#SBATCH --cpus-per-task=4
#SBATCH -t 14-00:00:00

#####
# INFO:
# Script to run chrombpnet contribution pipeline
#####

#####
# USAGE: sbatch --job-name=${dataset_name}_chrombpnet
#####

# Set-up env
source activate chrombpnet
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cellar/users/aklie/opt/miniconda3/envs/chrombpnet/lib
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# Set up args
model=$1
regions=$2
genome=$3
chromsizes=$4
out_prefix=$5

# Run cmd
cmd="chrombpnet contribs_bw \
-m $model \
-r $regions \
-g $genome \
-c $chromsizes \
-op $out_prefix"
echo -e $cmd
eval $cmd
