Run rsem to estimate gene expression levels
```
sbatch rsem.sh [sample list] [species]
```
`sample list`: a two-column table listing sample names and SRA accession number. For instance, `anole.sample_list` shows the sample accessions that were used in our study.
`species`: species name. The genome and gff paths need to be modified accordingly.

# Tissue specificity (tau)
The formula of tau calculation (`tau.source.r`) is modified from [here].
An custom R script for calculating tau in green anole is provided as `tau.r`.



 [here]: https://github.com/severinEvo/gene_expression
