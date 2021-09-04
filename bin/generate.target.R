options(echo=F) # if you want see commands in output file
args <- commandArgs(trailingOnly = TRUE)


# library(foreach)
# library(doParallel)

library(data.table)
library(plyr)

data1 <- fread(file = args[1],head = T)
data1<-data.frame(data1)
keep<-read.csv(file=args[2])
classified <- fread(file = args[3],head = T)
rank<-c("species","genus","family","order","class","phylum","kingdom")
tmp.lst<-list()
for(c in rank){
	lookat<-which(data1[,c] %in% keep[,c])
	tmp.lst[[c]]<-data1[lookat,]
}
tmp<-rbind.fill(tmp.lst)
tmp<-tmp[!duplicated(tmp$contig),]

id.to.keep<-tmp$contig
target<-setdiff(classified$readID,id.to.keep)

write.table(target,file = "target.txt",row.name=F, col.name=F,quote=F)