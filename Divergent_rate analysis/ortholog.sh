#!/bin/bash

#SBATCH --job-name=ortholog
#SBATCH --partition=basic,mcore
#SBATCH --cpus-per-task=6
#SBATCH --mem=2000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

module load ncbiblastplus

~/soft/proteinortho_v5.16/proteinortho5.pl -project=BOP -verbose -keep -identity=50 -cov=50 -synteny  -step=1 *.faa

~/soft/proteinortho_v5.16/proteinortho5.pl -project=BOP -verbose -keep -identity=50 -cov=50 -synteny -cpus=9 -step=2 *.faa

~/soft/proteinortho_v5.16/proteinortho5.pl -project=BOP -verbose -keep -identity=50 -cov=50 -synteny  -step=3 *.faa
