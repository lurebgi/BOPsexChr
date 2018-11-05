Run maker annotation pipeline
```
sbatch maker.sh [ctl file]
```
`ctl file`: the species-specific ctl file, e.g. maker_opts.lawesii.ctl

Run RepeatMasker
```
sbatch repeatmasker.sh [genome]
```
`genome`: the genome assembly in fasta format
