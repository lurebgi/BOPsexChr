**Run proteinortho5 to identify orthologous groups**
```
sbatch ortholog.sh
```
make sure all the protein sequence files (.faa) and gff files are located in the current directory

**Run guidance to do codon alignment for ortholgous coding sequences**
```
sbatch guidence.sh [gene]
# get cds alignment
ls -d 000_a* | grep -v out | while read line; do cat $line | while read hog; do mkdir $line.out/$hog/; cat tree.nwk.list | grep -f -  prank_out_msa/hog_$hog.fa | grep '>' | sed 's/>//' | ~/soft/seqkit grep -f - prank_out_msa/hog_$hog.fa | sed 's/_00.*//' | sed 's/_rna.*//' | sed 's/_evm.*//' | sed 's/_Fp.*//'  > $line.out/$hog/$hog.cds; done; done
# filter alignments for PAML
ls -d 000_a* | grep -v out | while read line; do cat $line | while read hog; do trimal -in $line.out/$hog/$hog.cds.newID  -out $line.out/$hog/$hog.cds.newID.phy -phylip_paml -gt 0.8; done; done
# get nwk files for PAML
ls -d 000_a* | grep -v out | while read line; do cat $line | while read hog; do GENELIST=$(cat $line.out/$hog/$hog.cds.newID.phy | awk '{print $1}' | sed 1d | grep -v ^$); nw_prune -v tree.nwk.newID $GENELIST > $line.out/$hog/$hog.nwk ; done; done
```
`gene`: The ID of an ortholgous group

**Run PAML to estimate free ratio substitution rates**
```
sbatch submit_paml.sh [gene]
```
`gene`: The ID of an ortholgous group. `13643.codeml.br.ctl` is an example ctl file
Many of the scripts of this part as well as CDS alignment part are modified from [here].

**To extract info (e.g. # substitution sites) from paml outputs**
```
sbatch extract_sub.sh
```

[here]: https://github.com/tsackton/ratite-genomics/tree/master/06_protein_coding_analysis
