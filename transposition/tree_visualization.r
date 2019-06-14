library("ggtree")

trees <- read.tree("/Users/luohao/drive/vienna/BOP/rubra_zw/paml/w_tree.length.nwk")

genes <- c("melk","SLC30A5","ANXA1")

ggtree(trees) + geom_tiplab(size=3)  + facet_wrap(~.id, scale="free", ncol=2) +
 xlim(0, 3)  + theme(strip.background = element_blank(), strip.text = element_blank()) +
 annotate(geom="text", x=10, y=0, label=genes,cex=3) +
 geom_text2(aes(subset=!is.na(as.numeric(label)) & as.numeric(label) > 0.6, label=as.integer((as.numeric(label))*100), hjust=1.16,y=y+0.3),size=2)
