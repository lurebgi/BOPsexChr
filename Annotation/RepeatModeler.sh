#!/bin/bash

#SBATCH --job-name=repMod
#SBATCH --partition=basic,molevo
#SBATCH --cpus-per-task=16
#SBATCH --mem=13000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

spe=$1

~/soft/RepeatModeler-open-1.0.9/BuildDatabase -name $spe.repeat_modeler -dir ./ $spe.fa
cp $spe.repeat_modeler.* $TMPDIR
/apps/repeatmodeler/1.0.10/RepeatModeler -database $TMPDIR/$spe.repeat_modeler -pa 16
