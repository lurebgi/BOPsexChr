#!/bin/bash

#SBATCH --job-name=repMask
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=20
#SBATCH --mem=3000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err
#SBATCH --license=scratch-highio
#SBATCH --nice=5000


module load repeatmasker
module load ncbiblastplus

genome=$1

mkdir ${genome}_RM_output_dir

cp /proj/luohao/BOP/assembly/$genome $TMPDIR

RepeatMasker -pa 20 -a -xsmall -gccalc -dir ${genome}_RM_output_dir -lib ~/soft/RepeatMasker/Libraries/RepeatMasker.avian.lib  $TMPDIR/$genome
