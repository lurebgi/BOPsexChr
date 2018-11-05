**Run pair-wise alignment**
```
sbatch nucmer.sh [reference] [query]
```
`reference`: Z chromosome sequence of species A, in fasta format

`query`: Z chromosome sequence of species B, in fasta format

This will produce a `rf` file that will be used for synteny plotting. By default alignments whose size are less than 2kb are removed.

**Plot pair-wise synteny**
```
Rscript pairwise.rf.r [rf file] [out]
```
`rf file`: the final output of `nucmer.sh`.

`out`: the name of output PDF

**Plot multiple pair-wise synteny (Fig. 2A)**
```
cat *.rf > all.rf
Rscript multiple.rf.r all.rf all.rf.pdf
```
