#!/bin/bash

#SBATCH --job-name=bwa
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=14000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=american_crow-%j.out
#SBATCH --error=american_crow-%j.err

module load sratoolkit bwa

genome=$1
male1=$2
male2=$3
female1=$4
female2=$5

cp $genome $TMPDIR
bwa index $TMPDIR/$genome
samtools faidx $genome
cut -f 1,2 $genome.fai | awk '{print $1"\t1\t"$2}' > $genome.fai.bed

bwa mem -t 8 american_crow.fa $male1 $male2 | samtools sort -@8 -O BAM -o $TMPDIR/$genome.male.BAM
samtools index $TMPDIR/male.BAM

bwa mem -t 8 american_crow.fa $female1 $female2 | samtools sort -@8 -O BAM -o $TMPDIR/$genome.female.BAM
samtools index $TMPDIR/female.BAM


samtools depth -m 100 -q 20 -Q 10 $TMPDIR/$genome.male.BAM | awk '$3<50{print $1"\t"$2"\t"$2+1"\t"$3} ' | bedtools map -a $genome.fai.bed -b -  -c 4 -o median,mean,count > $genome.male.BAM.coverage
samtools depth -m 100 -q 20 -Q 10 $TMPDIR/$genome.female.BAM | awk '$3<80{print $1"\t"$2"\t"$2+1"\t"$3} ' | bedtools map -a $genome.fai.bed -b -  -c 4 -o median,mean,count > $genome.female.BAM.coverage
