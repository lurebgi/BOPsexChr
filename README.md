This page demonstrates the analyses of sex-linked sequences, including demarcating evolutionary strata and verification of W-linked sequences. Other analyses can be found in directories [Annotation], [Divergent_rate analysis], [synteny] and [RNA-seq analysis].

## Sequence similarity between the Z and W
The analysis of sequence similarity between ZW help demarcate the evolutionary strata of avian sex chromosomes (Fig. 2A).

```
# calculating sequence similarity over 100k sliding windows on the Z chromosome
sh lastz.psl-100k_sim.sh [out_dir] [chrZ sequence] [W scaffolds]
```
`out_dir`: the output directory.

`chrZ sequence`: the Z chromosome sequence in fasta format. Z-linked scaffolds need to be linked into a single pseudochromosome.

`W scaffolds`: W-linked scaffolds or contigs in fasta format. Repeats need to be masked.

[Lastz] and [ucscGenomeBrowser] utility need to be installed.

z-w.psl.score.ide95.filt.ide-100k in the out_dir is the final output. The second column is the position of alignments on the Z chromosome. The third column is total number of mismatches and the fourth column is the alignment length. The last column shows the sequence similarity of a 100k sliding window on the Z.


```
# Plotting sequencing similarity along the Z chromosome
Rscript sim100k.r [ide-100k] [alignment size] [output name]
```
`ide-100k`: z-w.psl.score.ide95.filt.ide-100k file produced by `lastz.psl-100k_sim.sh`

`alignment size`: alignments with length below this values will be removed. The default size is 3000

`output name`: the output pdf name

R package [ggplot2] needs to be installed. An example input file 'lawesii.z-w.psl.score.ide95.filt.ide-100k' is provided.

## W-linked sequence verification
It's possible to verify W-linked scaffolds only when male sequencing data is available.  

```
# Calculating sequencing depth and coverage
sbatch m-f.coverag.sh [genome] [male reads 1] [male reads 2] [female reads 1] [female reads 2]
```
`genome`: the genome assembly in fasta format.

`male/female reads *`: full paths for male and female sequence data that are in fastq format

This will generate `male.BAM.coverage` and `female.BAM.coverage` files. Each row represents one scaffold, with information of total scaffold size (3rd column), sequencing depth (4th column), and sequencing coverage (5th column). The ratio of mappable site is calculated by dividing the sequencing coverage by scaffold size.

After retrieving the scaffolds derived from chr5, chrZ and chrW, into a file, e.g. 'femaleCov.m2f', one can plot female coverage (Y axis) and m/f ratios of mappable site (X axis).
```
Rscript m2f_ratio.r [species]
```
`species`: species name, e.g. medium_ground_finch.

This script can reproduce Fig. 1A.

## Genome assemblies and raw data
NCBI BioProject [PRJNA491255]


[lastz]: http://www.bx.psu.edu/~rsharris/lastz/
[ucscGenomeBrowser]: https://github.com/ucscGenomeBrowser/kent
[ggplot2]: https://cran.r-project.org/web/packages/ggplot2/index.html
[PRJNA491255]: https://www.ncbi.nlm.nih.gov/bioproject/PRJNA491255
[Annotation]: https://github.com/lurebgi/BOPsexChr/tree/master/Annotation
[Divergent_rate analysis]: https://github.com/lurebgi/BOPsexChr/tree/master/Divergent_rate%20analysis
[RNA-seq analysis]: https://github.com/lurebgi/BOPsexChr/tree/master/RNA-seq%20analysis
[synteny]: https://github.com/lurebgi/BOPsexChr/tree/master/synteny
