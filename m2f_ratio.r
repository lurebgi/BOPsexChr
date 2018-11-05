library("ggplot2")
args <- commandArgs(trailingOnly=TRUE)

data <- read.table("/Users/luohao/drive/vienna/BOP/W-identification/male_reads_verification/femaleCov.m2f")
df <- data.frame(chr=data[,4],m2f=data[,3],coverage=data[,2],spe=data[,6],len=data[,5])

# for all species
#ggplot(df) + geom_point(aes(y=coverage,x=m2f,size=len,col=chr),shape=1) + theme(legend.position = "top") + xlab("m/f mappable site") + facet_wrap(~spe,nrow=2,scales = "free_y") + scale_color_manual(breaks=c("chr5","z","w"),values=c("#c77cff","#f8766d" ,"#66c2a5"))

# for one species, e.g medium_ground_finch
ggplot(df[df$spe==args[1],]) + geom_point(aes(y=coverage,x=m2f,size=len,col=chr),shape=1) + theme(legend.position = "top") + xlab("m/f mappable site") + scale_color_manual(breaks=c("chr5","z","w"),values=c("#c77cff","#f8766d" ,"#66c2a5"))
