#!/bin/bash
#
#SBATCH --job-name=augustus
#SBATCH --cpus-per-task=32
#SBATCH --mem=1000
#SBATCH --partition=basic,himem
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=raw.fc-%j.out
#SBATCH --error=raw.fc-%j.err


module load snap augustus
maker2zff  ${spe}_genome.gff

# SNAP
fathom genome.ann genome.dna -gene-stats > gene-stats.log 2>&1
fathom genome.ann genome.dna -validate > validate.log 2>&1
fathom genome.ann genome.dna -categorize 1000 > categorize.log 2>&1
fathom -export 1000 -plus uni.ann uni.dna
forge export.ann export.dna
mkdir params
cd params
forge ../export.ann ../export.dna
cd ..
hmm-assembler.pl $spe params  >$spe.hmm


# augustus
zff2gff3.pl genome.ann |  perl -plne 's/\t(\S+)$/\t\.\t$1/' > $spe.initial.gff3
new_species.pl --species=$spe  --AUGUSTUS_CONFIG_PATH=/scratch/luohao/Fish/annotation/augustus/config
gff2gbSmallDNA.pl $spe.initial.gff3 genome.dna 1000 $spe.gb
etraining --AUGUSTUS_CONFIG_PATH=/scratch/luohao/Fish/annotation/augustus/config  --species=$spe $spe.gb

/apps/perl/5.28.0/bin/perl /apps/augustus/3.3/scripts/optimize_augustus.pl --AUGUSTUS_CONFIG_PATH=/scratch/luohao/Fish/annotation/augustus/config  --species=$spe $spe.gb --cpus=32 1>$spe.augustOpt.stdout 2>$spe.augustOpt.stderr



