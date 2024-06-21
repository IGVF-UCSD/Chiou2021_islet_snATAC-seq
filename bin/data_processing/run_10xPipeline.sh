inbam_path=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/23Oct23/cellranger/MM168/outs/possorted_bam.bam
outdir_prefix=/cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/processed/27Oct23/10xPipeline/MM168
name=MM168
script=/cellar/users/aklie/opt/igvf-ucsd/single_cell_utilities/data_processing/10xPipeline.py

# Run
cmd="python $script \
-b $inbam_path 
-o $outdir_prefix \
-n $name
--threads 8 \
--skip-convert \
--skip-rmdup \
--skip-qc"
echo $cmd