library(ggplot2)
library(ggpubr)

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/zw_synteny/w_1.fa.delta.filt.coords")
df1 <- data.frame(st=data[,1],end=data[,2])
df1w <- data.frame(st=data[,3],end=data[,4])

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/zw_synteny/w_2.fa.delta.filt.coords")
df2 <- data.frame(st=data[,1],end=data[,2])
df2w <- data.frame(st=data[,3],end=data[,4])

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/zw_synteny/gene.pos")
gene <- data.frame(st=data[,2],end=data[,3],strand=data[,4])

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/zw_synteny/gene.exon.pos")
exon <- data.frame(st=data[,2],end=data[,3],strand=data[,4])


ggplot(df1) + geom_rect(aes(xmin=st,xmax=end,ymin=1,ymax=2),fill="grey") +
geom_rect(data=df2,aes(xmin=st,xmax=end,ymin=1,ymax=1.5),fill="blue")  +
geom_rect(data=df1w,aes(xmin=st+1000000,xmax=end+1000000,ymin=3,ymax=4),fill="blue")  +
geom_rect(data=df2w,aes(xmin=st+1600000,xmax=end+1600000,ymin=3,ymax=4),fill="blue") +
geom_rect(data=exon,aes(xmin=st,xmax=end,ymin=-1,ymax=0,fill=strand,col=strand),size=0.4) +
geom_segment(data=gene,aes(x=st,xend=end,y=-0.5,yend=-0.5),size=0.2)
