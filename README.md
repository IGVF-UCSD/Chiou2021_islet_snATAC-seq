# Chiou2021_islet_snATAC-seq

Primary human islet snATAC-seq data from 3 donors, reprocessed with chromap and aligned to hg38.

## Publication

Chiou et al., *Nature Genetics* (2021): [https://www.nature.com/articles/s41588-021-00823-0](https://www.nature.com/articles/s41588-021-00823-0)

## Data summary

- **Assay:** snATAC-seq
- **Source:** Primary human islets
- **Samples:** 3 donors
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

## Cluster location

```
/cellar/users/aklie/data/datasets/Chiou2021_islet_snATAC-seq
```
