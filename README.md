# Chiou2021_islet_snATAC-seq

Primary human islet snATAC-seq data from 3 donors, reprocessed with chromap and aligned to hg38.

## Publication

Chiou et al., *Nature Genetics* (2021): [https://www.nature.com/articles/s41588-021-00823-0](https://www.nature.com/articles/s41588-021-00823-0)

## Google Drive

[Project folder](https://drive.google.com/drive/folders/1ZDjzVpofqTQ1-u8EVcg3aBS5QJILPcP2)

## Data summary

- **Assay:** snATAC-seq
- **Source:** Primary human islets
- **Samples:** 5 total in SRA; 3 donors used (ignored CB and 10x for nPOD_6004)
- **Raw data:** Downloaded from SRA (SRP290255)
- **Alignment:** Reprocessed with chromap, aligned to hg38
- **QC:** 13,859 cells passed QC
- **Annotation:** 12,806 cells annotated (92.4% of QC-passing cells)
- **Analysis tool:** SnapATAC2

## Processing roadmap

| Step | Directory | Description |
|------|-----------|-------------|
| 1 | `bin/data_acquisition/` | Download from SRA |
| 2 | `bin/data_processing/` | Alignment with chromap (hg38) |
| 3 | `bin/sample_annotation/` | QC filtering and cell type annotation |
| 4 | `bin/integration/` | Sample integration |
| 5 | `bin/sequence_models/` | ChromBPNet sequence model training |

### Step 1 -- Data acquisition

Downloaded FASTQs for 5 total snATAC-seq samples from SRA: `SRP290255`. Only 3 samples from different donors were carried forward (CB and 10x replicates for nPOD_6004 were excluded).

### Step 2 -- Alignment

Reprocessed with chromap, aligned to hg38.

### Step 3 -- Sample QC (SnapATAC2)

Ran SnapATAC2 pipeline on the 3 donor samples.

<details><summary>SnapATAC2 QC configuration</summary>

```yaml
io:
  chunk_size: 2000
  min_load_num_fragments: 1000
  sorted_by_barcode: false
  save_intermediate: true
  gene_activity: false
qc:
  max_num_fragments: 60000
  min_num_fragments: 1000
  min_tsse: 12
  additional_doublets: /cellar/users/aklie/data/datasets/islet_10X-Multiome/results/sample_annotation/amulet_bcs.txt
feature_selection:
  bin_size: 5000
  num_features: 100000
analysis:
  clustering_resolution: 1
```

</details>

- **13,859** total cells passed QC

### Step 4 -- Integration and annotation

Ran SnapATAC2 integration and annotation:
- **12,806** cells annotated (92.4% of QC-passing cells)
- Filtered down to annotated cells and used dimensionality reductions from the publication

### Step 5 -- Pseudobulk and peak calling

Pseudobulk profiles generated grouped by cell type.

## Cluster location

```
/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq
```
