# Chiou2021_islet_snATAC-seq

Public snATAC-seq atlas of primary human pancreatic islet / whole pancreas (Chiou et al. 2021), reprocessed in-house with chromap + SnapATAC2 and used as a primary-islet comparator and ChromBPNet training source for the stimulated SC-islet project.

## Source
- **Reference:** Chiou J, Zeng C, Cheng Z, et al. Single-cell chromatin accessibility identifies pancreatic islet cell type- and state-specific regulatory programs of diabetes risk. *Nature Genetics*. 2021;53:455-466. doi:10.1038/s41588-021-00823-0
- **Accession(s):** GEO GSE160472 / SRA SRP290255 (snATAC-seq sub-study). 5 SRR runs: SRR12957013-SRR12957016, SRR14135828.
- **Provenance:** Raw FASTQs pulled from SRA via `bin/data_acquisition/1_sra_download.{ipynb,py,sh}`; supplementary/processed cluster labels and HVW peaks pulled from the publication into `ref/publication/`.
- **Local path:** `/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq/` (symlinked from `public-data/Chiou2021_islet_snATAC-seq/`)

## Study design
- **Organism:** Homo sapiens
- **Assay:** snATAC-seq (Combinatorial Barcoding "CB" platform + 10x Chromium scATAC), paired-end Illumina (HiSeq 2500, NextSeq 500)
- **Conditions:** Non-diabetic donors only in this download (the Chiou 2021 paper additionally profiled T2D donors via scRNA-seq; T2D snATAC samples are not represented in the 5 SRRs cached here)
- **Samples (5 libraries / 4 donors):**
  - `UNOS_AFC2208` — pancreatic islets, M, 32y, BMI 32.3 (Islet 1, CB)
  - `UNOS_AFEA331` — pancreatic islets, M, 45y, BMI 29.3 (Islet 2, CB)
  - `UNOS_AFEP022` — pancreatic islets, M, 62y, BMI 36.1 (Islet 3, CB)
  - `nPOD_6004_CB` — whole pancreas, M, 33y, BMI 30.9 (Pancreas 1, CB)
  - `nPOD_6004_10x` — whole pancreas, M, 33y, BMI 30.9 (Pancreas 1, 10x — paired with `nPOD_6004_CB`)
- **Genome build:** hg38 (chromap reference; `ref/publication/hg38_lif_islet.hvw.bed` indicates lift-over to hg38)
- **Cell-type labels (from publication, `ref/publication/islet.cluster_labels.txt`):** alpha_1/2, beta_1/2, delta_1/2, gamma, acinar, ductal, stellate, endothelial, immune
- **Cell count:** _TODO_: confirm post-QC cell count for the in-house reprocessing (paper reports ~14k islet nuclei + pancreas; TODAY.md "~18k cells" claim refers to a different Chiou-related combo and should not be quoted here)

## What's here
```
bin/
  data_acquisition/      SRA + GEO download notebooks; SRP290255_metadata.tsv, SRP290255_srr_ids.txt
  data_processing/       chromap + cellranger-atac wrappers (run_chromap_on_{10x,CB}.sh, SLURM_ARRAY_run_cellranger-atac.sh)
  sample_annotation/     SnapATAC2 per-sample QC + clustering driver (process_ATAC.sh + scripts/)
  integration/           Cross-sample integration, cluster annotation, peak calling, peak analysis (5 stages)
  sequence_models/       ChromBPNet + BPNet-lite training (chromBPNetLitePipeline.sh, chrombpnet/, runs/fold_0.sh, create_seqdata.ipynb, train_model.ipynb)
  slurm_logs/
metadata/
  sample_metadata.tsv               5-row donor table
  2024_04_22/snapatac2_process.tsv  per-sample annotation manifest
  2024_06_03/snapatac2_integrate.tsv integration manifest
processed/
  chromap/                          5 sample dirs of chromap fragment outputs
ref/
  islet.marker_genes.csv, islet_marker_genelist.txt, cellid_colors.csv
  islet_tf_motifs.meme.txt, motifs.meme.txt
  publication/                      paper-supplied cluster labels, QC metrics, HVW peak sets (hg19 + hg38 lifted)
results/
  sample_annotation/                per-sample SnapATAC2 outputs (5 sample dirs)
  integration/atac/                 merged + annotated h5ads, paper_annotations.h5ad, peak_calls/, peak_matrices/, fragments/, coverage/, filtered_peaks/, umap.png
  sequence_models/
    chrombpnet/chrombpnet/fold_0/   trained ChromBPNet model (fold 0 of 5; folds 1-4 have negatives + auxiliary only)
    bpnet-lite/fold_0/              BPNet-lite training output
    eugene/, insertion_counts/, loci/, zarrs/   intermediate sequence-data artifacts
```

## Status
- **Pipeline state:** model-trained (ChromBPNet fold 0; folds 1-4 prepared but training _TODO_: confirm)
- **Latest run:** 2024_06_05 (notebook timestamps in `bin/integration/` and `bin/sequence_models/`)
- **Current limitation / blocker:** Only 1 of 5 ChromBPNet folds has a fully trained model on disk; integration QA (`5_viz_python.ipynb`) was the last touch. Genome-build / gene-naming verification still needed before joint integration with Maestas/Wang per issue #10.
- **Owner:** aklie

## Use in this project
- **Why we have it:** Primary-islet snATAC reference for the stimulated SC-islet project — provides T2D-relevant chromatin accessibility, paper-curated cell-type labels, and a ChromBPNet model trained on a non-stimulated primary-islet baseline for comparison against in-house treated SC-islet and EndoC models.
- **Linked issues:** IGVF-UCSD/.github #10 (primary islet integration: Chiou + Maestas + Wang)
- **Scratch workspace:** _TODO_: no dedicated scratch dir under `igvf-data/igvf_sc-islet_10X-Multiome/scratch/` was confirmed for this dataset
- **Manuscript:** ChromBetaNet (sequence-model comparator); beta_cell_networks (primary-islet reference for cell-type label transfer)
