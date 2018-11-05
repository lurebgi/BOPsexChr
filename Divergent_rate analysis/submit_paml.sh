#!/bin/bash

#SBATCH --job-name=paml
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=1
#SBATCH --mem=800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=log/%j.out
#SBATCH --error=log/%j.err
#SBATCH --nice=1000
#a#SBATCH --constraint=array-1core|array-4core


module load paml
hog=$1

codeml $hog.ctl
