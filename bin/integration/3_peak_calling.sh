script_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/bin/integration/scripts/snapatac2_peak_calling.sh
input_h5ads_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/integration/atac/merged.h5ads
annotations_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/integration/atac/paper_annotations.txt
outdir_path=/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/results/integration/atac

sbatch --job-name=Chiou2021_islet_snATAC-seq_snapatac2_peak_calling $script_path $input_h5ads_path $outdir_path $annotations_path
