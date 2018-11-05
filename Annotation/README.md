
**Run maker annotation pipeline**
```
sbatch maker.sh [ctl file]
```
`ctl file`: the species-specific ctl file, e.g. maker_opts.lawesii.ctl

**To train gene models using SNAP and augustus**
```
sbatch training [species]
```
`species`: species name, e.g. lawesii


**Run RepeatModeler**
```
sbatch RepeatModeler.sh [species name]
```
`species name`: e.g. lawesii, and make sure lawesii.fa is located in currect directory


**Run RepeatMasker**
```
sbatch repeatmasker.sh [genome]
```
`genome`: the genome assembly in fasta format
