#!/bin/bash

#SBATCH --job-name=paml
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

# number of substitution sites
ls | grep 000_a | grep -v gz |  while read a; do ls $a | while read b; do cat $a/$b/br.out  | grep -A 2 '^ branch' | grep '\.\.' |  awk '{print $3"\t"$4}' |  sed "s/^/$b\t/" ;done ; done > /scratch/luohao/BOP/paml_br/oneBOP/N-S-site

ls | grep 000_a | grep -v gz |  while read a; do ls $a | while read b; do

cat $a/$b/br.out | grep -A1 'TreeView' | sed 1d | sed 's/) #/)/g' | sed 's/#/:/g' > dnds.nwk
cat $a/$b/br.out | grep -A1 'dS tree' | sed 1d | sed 's/):/)/g'  > ds.nwk
cat $a/$b/br.out | grep -A1 'dN tree' | sed 1d | sed 's/):/)/g'  > dn.nwk

# internal branches
cat clade | while read line; do cat dnds.nwk | sed 's/):/)/g' | ~/soft/newick-utils-1.6/src/nw_clade - $line  |  ~/soft/newick-utils-1.6/src/nw_labels -r - | awk '{print $1}'; done  |  grep -v WARN | paste - clade | sed "s/^/$b\t/"  >> /scratch/luohao/BOP/paml_br/oneBOP/dnds_branch
cat clade | while read line; do cat ds.nwk | sed 's/):/)/g' | ~/soft/newick-utils-1.6/src/nw_clade - $line  |  ~/soft/newick-utils-1.6/src/nw_labels -r - | awk '{print $1}'; done  |  grep -v WARN | paste - clade | sed "s/^/$b\t/"  >> /scratch/luohao/BOP/paml_br/oneBOP/ds_branch
cat clade | while read line; do cat dn.nwk | sed 's/):/)/g' | ~/soft/newick-utils-1.6/src/nw_clade - $line  |  ~/soft/newick-utils-1.6/src/nw_labels -r - | awk '{print $1}'; done  |  grep -v WARN | paste - clade | sed "s/^/$b\t/"  >> /scratch/luohao/BOP/paml_br/oneBOP/dn_branch

## tips
cat $a/$b/br.out | grep -A1 'dN tree'  | sed 's/,/\n/g' | sed 's/.*(//' | sed 's/).*//' | sed 's/://' | sed 1d | awk '{print $1"\t"$2}' | sed "s/^/$b\t/"  >> /scratch/luohao/BOP/paml_br/oneBOP/dn_tip
cat $a/$b/br.out | grep -A1 'dS tree'  | sed 's/,/\n/g' | sed 's/.*(//' | sed 's/).*//' | sed 's/://' | sed 1d | awk '{print $1"\t"$2}' | sed "s/^/$b\t/"  >> /scratch/luohao/BOP/paml_br/oneBOP/ds_tip
cat $a/$b/br.out | grep -A1 'TreeView' | sed 1d | sed 's/) #/)/g' | sed 's/#/:/g' | sed 's/,/\n/g' | sed 's/.*(//' | sed 's/).*//' | sed 's/://'  | awk '{print $1"\t"$2}' | sed "s/^/$b\t/"  >> /scratch/luohao/BOP/paml_br/oneBOP/dnds_tip


done
#done
