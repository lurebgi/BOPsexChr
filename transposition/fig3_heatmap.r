library(reshape2)
library(ggplot2)
library(ggpubr)

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/expression/ortholog.gonad.mean.brain-liver-spleen.all.heart",na.strings = "NA")
df <- data.frame(spe=data[,1],sex=data[,2],gonad=data[,3],brain=data[,4],liver=data[,5],spleen=data[,6],gene=data[,7],heart=data[,8])
df1 <- melt(df,id.vars = c("spe","sex","gene"),variable.name ="tissue",value.name ="tpm")
df12 <- data.frame(tissue=paste(df1$tissue,df$sex,sep = "_"),spe=df$spe,tissue=df1$tissue,tpm=df1$tpm,gene=df$gene)

df12$tissue <- factor(df12$tissue,levels = c("gonad_female","gonad_male","brain_female","brain_male","liver_female","liver_male","spleen_female","spleen_male","heart_female","heart_male"))
df12$spe <- factor(df12$spe,levels=rev(c("great_tit","blue_tit","collared_flycatcher","rock_pigeon","turkey","chicken","guineafowl","goose","duck","Chilean_tinamou","anole")))
df12$gene <- factor(df12$gene,levels=c("SERINC5","THBS4","MTX3","melk","SLC30A5","anxa1","aldh1a1"))

col927<-colorRampPalette(rev(c("#800026","#fc4e2a", "#ffffbf","#3690c0")))(50)

ggplot(df12) + geom_tile(aes(x=tissue,y=spe,fill=log1p(tpm)),col="white") +  scale_fill_gradientn(colors =col927) + facet_wrap(~gene,nrow=1) + theme_pubr()
