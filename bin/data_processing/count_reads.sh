# mamba activate get_data

seqkit stats \
--threads 24 \
--tabular /cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/fastq/04Jul23/*/*.fastq.gz \
> /cellar/users/aklie/data/datasets/Zhu2023_sc-islet_snATAC-seq/metadata/fastq_stats.tsv
