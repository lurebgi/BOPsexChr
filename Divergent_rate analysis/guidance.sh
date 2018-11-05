#!/bin/bash
#SBATCH --job-name=prank
#SBATCH --partition=basic,molevo
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=log/%j.out
#SBATCH --error=log/%j.err

line=$1
guidence=/proj/zongji/Genome-scale_phylogeny_of_Paleognathous_birds/guidance.v2.02/www/Guidance/guidance.pl
prank=/apps/prank/170427/bin/prank


perl $guidence  --seqFile /scratch/luohao/BOP/paml_br/cds/$line.fa.filt.v2.mask.temp --msaProgram PRANK --seqType codon --outDir /scratch/luohao/BOP/paml_br/prank_out.v2/$line --bootstraps 10 --prank $prank
