#!/bin/bash

#SBATCH --job-name=bwa
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=14000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=american_crow-%j.out
#SBATCH --error=american_crow-%j.err
#SBATCH --constraint=array-8core

genome=$1
sample=$2
module load sratoolkit bwa

bwa index $genome index/$genome
#sample=$(sed -n ${SLURM_ARRAY_TASK_ID}p sample.list.withFemale.sex.bwa.unfinished | cut -f 1)


cp  index/* $TMPDIR


#bwa mem -t 8 $TMPDIR/medium_ground_finch.fa <(zcat *_${sample}_1.fastq.gz) <(zcat *_${sample}_2.fastq.gz)  | samtools sort -@ 8 - -O BAM -o $TMPDIR/${sample}.sort.bam
bwa mem -t 8 $TMPDIR/$genome ${sample}_1.fastq.gz ${sample}_2.fastq.gz  | samtools sort -@ 8 - -O BAM -o $TMPDIR/${sample}.sort.bam

mv $TMPDIR/${sample}.sort.bam .

samtools faidx $genome
cut -f 1,2 $genome.fai > $genome.fai.g
bedtools makewindows -g $genome.fai.g -w 50000 > $genome.scf-len.50k-win

samtools depth -m 100 -q 20 -Q 59 ${sample}.sort.bam  | awk '$3<80{print $1"\t"$2"\t"$2+1"\t"$3}' | bedtools map -a $genome.scf-len.50k-win -b -  -c 4 -o median,mean,count > ${sample}.bam.50k
