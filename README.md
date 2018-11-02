## Calculating sequence similarity between the Z and W

```
sh lastz.psl-100k_sim.sh [out_dir] [chrZ sequence] [W scaffolds]
```
out_dir: the output directory
chrZ sequence: the Z chromosome sequence in fasta format. Z-linked scaffolds need to be linked into a single pseudochromosome.
W scaffolds: W-linked scaffolds or contigs in fasta format. Repeats need to be masked.

z-w.psl.score.ide95.filt.ide-100k in the out_dir is the final output. The second column is the position of alignments on the Z chromosome. The third column is total number of mismatches and the fourth column is the alignment length. The last column shows the sequence similarity of a 100k sliding window on the Z. 
