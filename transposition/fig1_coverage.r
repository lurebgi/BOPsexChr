library(ggplot2)
library(ggpubr)


# great tit
#data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/great_tit.z.50k")
#data <- data[which(data[,6]/(data[,3]-data[,2])>0.6),]
#df <- data.frame(pos=data[,2],cov=data[,5],sex="female")
#pcovf_gt_f <- ggplot(df) + geom_point(aes(x=pos,y=cov), col="#d1c26c",alpha=0.7) + ylab("Coverage") + theme_pubr() + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000)) + theme(axis.title.x=element_blank(),axis.text.x=element_blank())
data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/m2f/great_tit.z.m2f")
df <- data.frame(pos=data[,2],cov=data[,4])
pcovf_gt <- ggplot(df) + geom_point(aes(x=pos,y=cov), col="#d1c26c",alpha=0.7) + ylab("Coverage") + theme_pubr() + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000)) + theme(axis.title.x=element_blank(),axis.text.x=element_blank())

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/m2f/great_tit.z.snp.m2f")
df <- data.frame(pos=data[,2],snp=data[,4])
psnpf_gt <- ggplot(df) + geom_point(aes(x=pos,y=snp), col="#a6cee3",alpha=0.7)  + ylab(gsub(" ", "\n","SNP density")) + theme_pubr()   + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000), labels = c("10M","30M","50M","70M")) + theme(axis.title.x=element_blank())


# medium ground finch
#data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/SRR448683.bam.50k.chrZ")
#data <- data[which(data[,6]>30000),]
#df <- data.frame(pos=data[,7],cov=data[,5],sex="female")
#pcovf_mgf_f <- ggplot(df) + geom_point(aes(x=pos,y=cov), col="#d1c26c",alpha=0.7) + ylab("Coverage") +  theme_pubr() + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000)) + theme(axis.title.x=element_blank(),axis.text.x=element_blank())
data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/m2f/medium_ground_finch.z.m2f")
df <- data.frame(pos=data[,2],cov=data[,4])
pcovf_mgf <- ggplot(df) + geom_point(aes(x=pos,y=cov), col="#d1c26c",alpha=0.7) + ylab("Coverage") +  theme_pubr() + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000)) + theme(axis.title.x=element_blank(),axis.text.x=element_blank())

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/m2f/medium_ground_finch.z.snp.m2f")
df <- data.frame(pos=data[,2],snp=data[,4])
psnpf_mgf <- ggplot(df) + geom_point(aes(x=pos,y=snp), col="#a6cee3",alpha=0.7)  + ylab(gsub(" ", "\n","SNP density")) + theme_pubr()   + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000), labels = c("10M","30M","50M","70M")) + theme(axis.title.x=element_blank())


# red BOP
#data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/z.bed.order.new.chr.female-180")
#data <- data[which(data[,6]>30000),]
#df <- data.frame(pos=data[,7],cov=data[,5],sex="female")
pcovf_bop_f <- ggplot(df) + geom_point(aes(x=pos,y=cov), col="#d1c26c",alpha=0.7) + ylab("Coverage") +  theme_pubr() + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000)) + theme(axis.title.x=element_blank(),axis.text.x=element_blank())
data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/m2f/bop.z.m2f")
df <- data.frame(pos=data[,2],cov=data[,4])
pcovf_bop <- ggplot(df) + geom_point(aes(x=pos,y=cov), col="#d1c26c",alpha=0.7) + ylab("Coverage") +  theme_pubr() + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000)) + theme(axis.title.x=element_blank(),axis.text.x=element_blank())

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/coverage/m2f/bop.z.snp.m2f")
df <- data.frame(pos=data[,2],snp=data[,4])
psnpf_bop <- ggplot(df) + geom_point(aes(x=pos,y=snp), col="#a6cee3",alpha=0.7)  + ylab(gsub(" ", "\n","SNP density")) + theme_pubr()   + scale_x_continuous(breaks = c(10000000,30000000,50000000,70000000), labels = c("10M","30M","50M","70M")) + theme(axis.title.x=element_blank())

ggarrange(pcovf_gt,psnpf_gt,pcovf_mgf,psnpf_mgf,pcovf_bop,psnpf_bop,nrow=6,ncol=1,align = "v")
