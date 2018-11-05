library("ggplot2")
args <- commandArgs(trailingOnly=TRUE)

data <- read.table(args[1])
pdf(args[2],height=8,width=9)

data <- read.table("/Users/luohao/drive/vienna/BOP/synteny/passerine_nucmer/coords.all")
df <- data.frame(x1=data[,1],x2=data[,2],pair=data[,4])

ggplot(df) + geom_segment(aes(x=x1,xend=x2,y=1,yend=2,col=strata)) +
facet_wrap(~spe,ncol=1,strip.position="top") +
theme(panel.border = element_blank(), panel.grid.major = element_blank(), strip.background = element_blank() , panel.grid.minor = element_blank(), axis.line =element_line(color = 'NA'),axis.title=element_blank(),axis.ticks=element_blank(),axis.text.y =element_blank()) +
scale_color_manual(breaks=c("S0","S1","S2","S3"),values=c("#3288bd","#d6ce36","#fdae61","#f46d43"))  + scale_x_continuous(breaks=c(0,20000000,40000000,60000000,80000000),labels=c("0","20M","40M","60M","80M"))

dev.off()
