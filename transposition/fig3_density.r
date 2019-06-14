library(ggplot2)
library(ggpubr)

data <- read.table("/Users/luohao/drive/vienna/BOP/rubra_zw/happloinsufficency/lost.hs")
#ggplot(data,aes(x=V1)) + geom_histogram(binwidth = 0.03) +
 geom_vline(xintercept = 0.716) + geom_vline(xintercept = 0.350)

3ggplot(data,aes(x=V1)) + geom_histogram(binwidth = 0.03) + geom_vline(xintercept = 0.131) +
geom_vline(xintercept = 0.154) + geom_vline(xintercept = 0.259) + geom_vline(xintercept = 0.453) +
 geom_vline(xintercept =0.504 )  + theme_pubr()
