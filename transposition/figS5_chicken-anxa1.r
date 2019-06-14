# https://hopstat.wordpress.com/2015/07/09/line-plots-of-longitudinal-summary-data-in-r-using-ggplot2-2/
data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/expression/anxa1.chicken.sample")
df <- data.frame(stage=data[,1],sex=data[,2],sample=paste(data[,1],data[,2],data[,3]),tpm=data[,4])

library(plyr)
library(ggplot2)


agg = ddply(df, .(stage, sex), function(x){ c(mean=mean(x$tpm), sd = sd(x$tpm)) })
agg$lower = agg$mean + agg$sd
agg$upper = agg$mean - agg$sd
agg$stage <- factor(agg$stage,levels = c("E6","E18","E19","adult1","adult2"))
agg$new_stage = as.numeric(agg$stage)

pd <- position_dodge(width = 0)

ggplot(agg, aes(y=mean,x=stage, colour=sex)) + geom_errorbar(aes(ymin=lower, ymax=upper), width=.3, position=pd) +
geom_point(position=pd) + geom_line(position=pd)  + geom_line(aes(x=new_stage) , position=pd)
