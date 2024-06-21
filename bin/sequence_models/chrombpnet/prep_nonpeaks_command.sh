# Script to prepare nonpeaks for Chiou2021_islet_snATAC-seq
script=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/sequence_models/chrombpnet/chrombpnet_prep_nonpeaks.sh
peaks=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/loci/beta_1.chrombpnet.narrowPeak
fold_dir=/cellar/users/aklie/data/ref/genomes/hg38/chrombpnet/splits
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet

# Fold 0
sbatch --job-name=Chiou2021_islet_snATAC-seq_prep_nonpeaks $script $peaks $fold_dir/fold_0.json $out_dir/fold_0

# Fold 1
sbatch --job-name=Chiou2021_islet_snATAC-seq_prep_nonpeaks $script $peaks $fold_dir/fold_1.json $out_dir/fold_1

# Fold 2
sbatch --job-name=Chiou2021_islet_snATAC-seq_prep_nonpeaks $script $peaks $fold_dir/fold_2.json $out_dir/fold_2

# Fold 3
sbatch --job-name=Chiou2021_islet_snATAC-seq_prep_nonpeaks $script $peaks $fold_dir/fold_3.json $out_dir/fold_3

# Fold 4
sbatch --job-name=Chiou2021_islet_snATAC-seq_prep_nonpeaks $script $peaks $fold_dir/fold_4.json $out_dir/fold_4
