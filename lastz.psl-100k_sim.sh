## usage: sh lastz.psl-100k_sim.sh [out_dir] [chrZ sequence] [W scaffolds]

# out_dir: the output directory
# chrZ sequence: the Z chromosome sequence in fasta format. Z-linked scaffolds need to be linked into a single pseudochromosome.
# W scaffolds: W-linked scaffolds or contigs. Repeats need to be masked.

module load ucsc lastz
spe=$1
Zfa=$2
Wfa=$3

mkdir $spe

lastz $Zfa $Wfa  --step=19 --hspthresh=2200 --inner=2000 --ydrop=3400 --gappedthresh=10000 --format=axt  > $spe/$spe.axt
axtChain $spe/$spe.axt -linearGap=medium  -faT $spe/$spe.z.fa -faQ $spe/$spe.w.list.mask.fa $spe/$spe.axt.chain 2> $spe/$spe.chain.log

faSize $Zfa  -detailed > $spe/$spe.z.fa.size
faSize $Wfa  -detailed > $spe/$spe.w.list.mask.fa.size
chainPreNet $spe/$spe.axt.chain $spe/$spe.z.fa.size $spe/$spe.w.list.mask.fa.size    $spe/$spe.axt.chain.filt

chainNet $spe/$spe.axt.chain.filt $spe/$spe.z.fa.size $spe/$spe.w.list.mask.fa.size  stdout /dev/null | netSyntenic stdin $spe/$spe.noClass.net

faToTwoBit $Zfa $spe/$spe.z.fa.2bit
faToTwoBit $Wfa $spe/$spe.w.list.mask.fa.2bit

netToAxt $spe/$spe.noClass.net $spe/$spe.axt.chain.filt $spe/$spe.z.fa.2bit $spe/$spe.w.list.mask.fa.2bit  stdout  | axtSort stdin $spe/$spe.z-w.axt

axtToMaf $spe/$spe.z-w.axt $spe/$spe.z.fa.size $spe/$spe.w.list.mask.fa.size   $spe/$spe.z-w.maf -qPrefix=W. -tPrefix=Z.

mafToPsl W Z $spe/$spe.z-w.maf $spe/$spe.z-w.psl

# filtering
pslScore $spe/$spe.z-w.psl > $spe/$spe.z-w.psl.score
cat $spe/$spe.z-w.psl.score |awk '$5>65 && $6>60 && $6<96' |  awk '{a[$1"_"$2]=3}END{while(getline < "'$spe'/'$spe'.z-w.psl"){if(a[$14"_"$16]==3){print $0}}}' > $spe/$spe.z-w.psl.score.ide95.filt

## 100k 
perl psl-100k_sim.pl $spe/$spe.z-w.psl.score.ide95.filt > $spe/$spe.z-w.psl.score.ide95.filt.100k
cat $spe/$spe.z-w.psl.score.ide95.filt.100k | awk 'NF==4{print $0"\t"100-$3/$4*100}' > $spe/$spe.z-w.psl.score.ide95.filt.ide-100k

