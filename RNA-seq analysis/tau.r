source("tau.source.r")
data <- read.table("/Users/luohao/drive/vienna/BOP/W-identification/expression/anole/anole.gene.list.strata.anole.b-h-k-l-g.f-m.tpm")
data <- (data[which(apply(data[,c(5:14),],1,sum)>10),])
dim(data)[1]
length(which(apply(data[,c(5:14)],1,tau)>0.8))
taurs <- apply(data[,c(5:14)],1,tau)
 rs <- data.frame(strata=data[,3],tau=taurs,type="Retained")

taurs <- cbind(taurs,"Restained")

data <- read.table("/Users/luohao/drive/vienna/BOP/W-identification/expression/anole/anole.z.gene.strata.b-h-k-l-g.f-m.tpm.rmZW")
data <- (data[which(apply(data[,c(5:14),],1,sum)>10),])
dim(data)[1]
length(which(apply(data[,c(5:14)],1,tau)>0.8))
tauls <- apply(data[,c(5:14)],1,tau)
 ls <- data.frame(strata=data[,3],tau=tauls,type="Lost")
tauls <- cbind(tauls,"Lost")

data <- read.table("/Users/luohao/drive/vienna/BOP/W-identification/expression/anole/autosome.b-h-k-l-g.f-m.tpm.orthlog")
data <- (data[which(apply(data[,c(2:11),],1,sum)>10),])
dim(data)[1]
length(which(apply(data[,c(2:11)],1,tau)>0.8))
taua <- apply(data[,c(2:11)],1,tau)
 a <- data.frame(strata="autosome",tau=taua,type="Autosome")
taua <- cbind(taua,"Autosome")

# strata combined
tauall <- rbind(taurs,tauls,taua)
df <- data.frame(tau = as.numeric(tauall[,1]),chr=tauall[,2])
ggplot(df) + geom_boxplot(aes(x=chr,y=tau),notch = T)

# strata separate
taualls <- rbind(rs,ls,a)
ggplot(taualls) + geom_boxplot(aes(x=chr,y=tau),notch = T)
ggplot(taualls) + geom_boxplot(aes(x=type,y=tau)) + facet_grid(~strata,space = "free_x",scales = "free_x")

ggplot(taualls) + geom_boxplot(aes(x=type,y=tau,col=type)) + facet_grid(~strata,space = "free_x",scales = "free_x")  + scale_color_manual(breaks=c("Retained","Lost","Autosome"),values=c( "#F8766D", "#00BA38","#619CFF"))
