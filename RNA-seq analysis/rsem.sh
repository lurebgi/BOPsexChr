#!/bin/bash

#SBATCH --job-name=rsem
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=30000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=rsem-%j.out
#SBATCH --error=rsem-%j.err
#SBATCH --nice=4000


module load rsem
module load star
module load cufflinks
module load sratoolkit

list=$1
spe=$2


ln -s /proj/luohao/avian_transcriptome/annotation/$spe.gff
ln -s /proj/luohao/avian_transcriptome/assembly/$spe.fa
# index
gffread $spe.gff -g $spe.fa -T -o $spe.gtf
cat $spe.gtf  | grep gene_id > $spe.gene.gtf
rsem-prepare-reference --gtf $spe.gene.gtf  --star $spe.fa $spe -p 2

rsync -aq *.tab *.txt chrLength.txt  chrName.txt  chrStart.txt  Genome  genomeParameters.txt  SA  SAindex $spe.*  $TMPDIR

cat $list |  while read sample sra; do

fastq-dump --outdir $TMPDIR  --split-files $sra
mkdir $TMPDIR/temp; rsem-calculate-expression $TMPDIR/${sra}_1.fastq $TMPDIR/${sra}_2.fastq  $TMPDIR/$spe   $sample --star -p 8 --paired-end  --no-bam-output  --temporary-folder=$TMPDIR/temp

rm $TMPDIR/${sra}*fastq

done
