#!/bin/bash

#SBATCH --job-name=nucmer
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=4
#SBATCH --mem=46000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

module load mummer

ref0=$1
spe=$2

ref=$(echo ${ref0##*/})

nucmer -b 500 -t 4 $ref0  $spe -p ${ref}-$spe
delta-filter -1 -l 500 ${ref}-$spe.delta > ${ref}-$spe.delta.filt
show-coords -H -c -l -o -r -T ${ref}-$spe.delta.filt > ${ref}-$spe.delta.filt.coords

cat ${ref}-$spe.delta.filt.coords |  awk '$5>2000' | awk '$3<$4{print $1"\t"$3"\tf\t"$(NF-1)"-"$NF"\n"$2"\t"$4"\tf\t"$(NF-1)"-"$NF}$3>$4{print $1"\t"$3"\tr\t"$(NF-1)"-"$NF"\n"$2"\t"$4"\tr\t"$(NF-1)"-"$NF}'  > ${ref}-$spe.delta.filt.coords.rf
