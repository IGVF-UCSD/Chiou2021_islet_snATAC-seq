# Script to run chrombpnet pipeline on Chiou2021_islet_snATAC-seq data
script=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/sequence_models/chrombpnet/chrombpnet_pipeline_ifrag.sh

# Sample specific info
fragments=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/integration/atac/fragments/beta_1.bed.gz
peaks=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/loci/beta_1.chrombpnet.narrowPeak
bias_model=/cellar/users/aklie/data/ref/bias_models/scATAC_dermal_fibroblast/scATAC_dermal_fibroblast.h5

# Fold 0
fold=0
fold_json=/cellar/users/aklie/data/ref/genomes/hg38/chrombpnet/splits/fold_${fold}.json
negatives=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet/fold_${fold}_negatives.bed
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet/chrombpnet/fold_${fold}
sbatch --job-name=Chiou2021_islet_snATAC-seq_chrombpnet_pipeline $script $fragments $peaks $negatives $fold_json $bias_model $out_dir

# Fold 1
fold=1
fold_json=/cellar/users/aklie/data/ref/genomes/hg38/chrombpnet/splits/fold_${fold}.json
negatives=/cellar/users/aklie/data/igvf/beta_cell_networks/peaks/Chiou2021_islet_snATAC-seq/fold_${fold}_negatives.bed
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet/chrombpnet/fold_${fold}
#sbatch --job-name=Chiou2021_islet_snATAC-seq_chrombpnet_pipeline $script $fragments $peaks $negatives $fold_json $bias_model $out_dir

# Fold 2
fold=2
fold_json=/cellar/users/aklie/data/ref/genomes/hg38/chrombpnet/splits/fold_${fold}.json
negatives=/cellar/users/aklie/data/igvf/beta_cell_networks/peaks/Chiou2021_islet_snATAC-seq/fold_${fold}_negatives.bed
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet/chrombpnet/fold_${fold}
#sbatch --job-name=Chiou2021_islet_snATAC-seq_chrombpnet_pipeline $script $fragments $peaks $negatives $fold_json $bias_model $out_dir

# Fold 3
fold=3
fold_json=/cellar/users/aklie/data/ref/genomes/hg38/chrombpnet/splits/fold_${fold}.json
negatives=/cellar/users/aklie/data/igvf/beta_cell_networks/peaks/Chiou2021_islet_snATAC-seq/fold_${fold}_negatives.bed
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet/chrombpnet/fold_${fold}
#sbatch --job-name=Chiou2021_islet_snATAC-seq_chrombpnet_pipeline $script $fragments $peaks $negatives $fold_json $bias_model $out_dir

# Fold 4
fold=4
fold_json=/cellar/users/aklie/data/ref/genomes/hg38/chrombpnet/splits/fold_${fold}.json
negatives=/cellar/users/aklie/data/igvf/beta_cell_networks/peaks/Chiou2021_islet_snATAC-seq/fold_${fold}_negatives.bed
out_dir=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sequence_models/chrombpnet/chrombpnet/fold_${fold}
#sbatch --job-name=Chiou2021_islet_snATAC-seq_chrombpnet_pipeline $script $fragments $peaks $negatives $fold_json $bias_model $out_dir
