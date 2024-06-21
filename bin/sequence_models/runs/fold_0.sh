script=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/bin/bpnet-lite/chromBPNetLitePipeline.sh
in_json=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/bin/bpnet-lite/configs/fold_0.json
outdir=/cellar/users/aklie/data/datasets/mo_EndoC-bH1_ATAC-seq/analysis/bpnet-lite/2024_05_29/fold_0/fold_0

sbatch --job-name=chromBPNetLite_pipeline $script $in_json $outdir
