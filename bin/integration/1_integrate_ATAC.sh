script_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/integration/scripts/snapatac2_integrate.sh
input_tsv=$1
outdir_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/integration/atac

sbatch --job-name=Chiou2021_islet_snATAC-seq_snapatac2_integrate $script_path $input_tsv $outdir_path
