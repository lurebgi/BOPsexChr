#!/bin/bash

#SBATCH --job-name=makerMPI
#SBATCH -N 1
#SBATCH --ntasks-per-node=16
#SBATCH --ntasks-per-core=2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=maker-%j.out
#SBATCH --error=maker-%j.err

ctl=$1

module  purge
module  load intel/16 openmpi/1.10.2 trf/4.0.9 bamtools/2.4.1 exonerate/2.2.0 python/2.7 snap/2013.11.29 augustus/3.2.3 boost/1.53.0 RMBlast/2.2.28 repeatmasker/4.0.7 maker/2.31.9

unset  AUGUSTUS_CONFIG_PATH
export AUGUSTUS_CONFIG_PATH=/global/lv70960/luohao/Fish/annotation/augustus_bin/config

srun -n 16  maker -fix_nucleotides  $ctl  maker_bopts.ctl  maker_exe.ctl
