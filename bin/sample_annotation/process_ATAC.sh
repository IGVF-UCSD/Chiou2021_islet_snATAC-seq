script_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/sample_annotation/scripts/snapatac2_process.sh
input_tsv=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/metadata/2024_04_22/snapatac2_process.tsv
outdir_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/sample_annotation

sbatch --job-name=islet_10X-Multiome_snapatac2_preprocess $script_path $input_tsv $outdir_path
