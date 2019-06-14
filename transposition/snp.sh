#!/bin/bash

#SBATCH --job-name=gvcf_mgfin
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=36000
#SBATCH --output=%j.bam2gvcf.out
#SBATCH --error=%j.bam2gvcf.err
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at

genome=$1
sample=$2
samtools index $sample.sort.bam
#samtools view -h $sample.sort.bam  NW_005054323.1 NW_005054335.1 NW_005054352.1 NW_005054355.1 NW_005054365.1 NW_005054378.1 NW_005054379.1 NW_005054385.1 NW_005054390.1 NW_005054401.1 NW_005054404.1 NW_005054427.1 NW_005054431.1 NW_005054440.1 NW_005054462.1 NW_005054467.1 NW_005054468.1 NW_005054471.1 NW_005054476.1 NW_005054480.1 NW_005054485.1 NW_005054526.1 NW_005054537.1 NW_005054542.1 NW_005054552.1 NW_005054554.1 NW_005054567.1 NW_005054579.1 NW_005054590.1 NW_005054601.1 NW_005054607.1 NW_005054608.1 NW_005054611.1 NW_005054619.1 NW_005054620.1 NW_005054628.1 NW_005054630.1 NW_005054632.1 NW_005054635.1 NW_005054638.1 NW_005054643.1 NW_005054657.1 NW_005054670.1 NW_005054698.1 NW_005054726.1 NW_005054749.1 NW_005054761.1 NW_005054789.1 NW_005054873.1 -O BAM -o $TMPDIR/$sample.sort.z.bam
#samtools index $TMPDIR/$sample.sort.z.bam
ulimit
/apps/java/1.8u152/bin/java -jar /apps/picard_tools/2.14.0/picard.jar AddOrReplaceReadGroups I=$TMPDIR/$sample.sort.bam  O=$TMPDIR/female_merge.sorted.bam RGID=female_merge RGLB=female_merge RGPL=Illumina RGPU=female_merge RGSM=female_merge CREATE_INDEX=True
samtools index $TMPDIR/female_merge.sorted.bam
java -jar /apps/picard_tools/2.14.0/picard.jar MarkDuplicates I=$TMPDIR/female_merge.sorted.bam O=$TMPDIR/female_merge.sorted.bam.dedup.bam M=female_merge.m MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=2000
samtools index $TMPDIR/female_merge.sorted.bam.dedup.bam
mv $TMPDIR/female_merge.sorted.bam.dedup.bam $sample.sort.dedup.bam
mv $TMPDIR/female_merge.sorted.bam.dedup.bam.bai $sample.sort.dedup.bam.bai

module unload java
module load java/1.8u152


/apps/java/1.8u152/bin/java -jar /apps/gatk/nightly-2017-12-12/GenomeAnalysisTK.jar  -R $genome -T HaplotypeCaller  -I $sample.sort.dedup.bam  -o $TMPDIR/$sample.sort.dedup.bam.vcf.gz -nct 4

#mv $TMPDIR/female_merge.sorted.bam.dedup.bam.vcf.gz* .

java -Xmx180g -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -T SelectVariants -R $genome -V $TMPDIR/$sample.sort.dedup.bam.vcf.gz  -selectType SNP -o $TMPDIR/female_merge.sorted.bam.dedup.bam.vcf
java -Xmx180g -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -T VariantFiltration -R $genome -V $TMPDIR/female_merge.sorted.bam.dedup.bam.vcf   -window 10 -cluster 2 -filterName FS -filter "FS > 10.0" -filterName QD -filter "QD < 2.0" -filterName MQ -filter "MQ < 50.0" -filterName SOR -filter "SOR > 1.5"  -filterName  DP -filter "DP > 150" -filterName MQRankSum -filter "MQRankSum < -1.5" -filterName ReadPosamplenkSum -filter "ReadPosamplenkSum < -8.0"  -o $TMPDIR/female_merge.sorted.bam.dedup.bam.filt.vcf
java -Xmx180g -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -T SelectVariants  -R $genome  -V $TMPDIR/female_merge.sorted.bam.dedup.bam.filt.vcf   --excludeFiltered -o $sample.sort.dedup.z.bam.final.vcf.gz
