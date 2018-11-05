Run proteinortho5 to identify orthologous groups
```
sbatch ortholog.sh
```
make sure all the protein sequence files (.faa) and gff files are located in the current directory

Run guidance to do codon alignment for ortholgous coding sequences
```
sbatch guidence.sh [gene]
```
`gene`: The ID of an ortholgous group

Run PAML to estimate free ratio substitution rates
```
sbatch submit_paml.sh [gene]
```
`gene`: The ID of an ortholgous group. `13643.codeml.br.ctl` is an example ctl file
