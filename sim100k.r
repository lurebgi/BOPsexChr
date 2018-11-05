library("ggplot2")
args <- commandArgs(trailingOnly=TRUE)
idelen <- 3000
idelen <- args[2]

data <- read.table(args[1])
data <- data[which(data[,4]>idelen),]

idedf <- data.frame(pos=data[,2]+50000,ide=data[,5],len=data[,4])

pdf(args[3],width=4,height=7)

ggplot(idedf,aes(x=pos,y=ide)) + geom_point(shape=21,stroke=1,aes(size=len)) + geom_smooth(se=F,span=0.2,method='loess',col="#99d594")    + scale_y_continuous(name="ZW identity") + theme(axis.title.x=element_blank(),axis.ticks.x=element_blank(),legend.position="top",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank())

dev.off()
