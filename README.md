## Sequence similarity between the Z and W

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
# Ploting sequencing similarity along the Z chromosome
Rscript sim100k.r [ide-100k] [alignment size] [output name]
```
`ide-100k`: z-w.psl.score.ide95.filt.ide-100k file produced by `lastz.psl-100k_sim.sh`

`alignment size`: alignments with length below this values will be removed. The default size is 3000

`output name`: the output pdf name

R package ggplot2 needs to be installed. An example input file 'lawesii.z-w.psl.score.ide95.filt.ide-100k' is provided.


## Citation
> Xu et al. Dynamic evolutionary history and gene content of sex chromosomes across diverse songbirds bioRxiv 454843; doi: https://doi.org/10.1101/454843


[lastz]: http://www.bx.psu.edu/~rsharris/lastz/
[ucscGenomeBrowser]: https://github.com/ucscGenomeBrowser/kent 
