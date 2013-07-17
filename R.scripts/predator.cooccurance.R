## R code for organizing predator co-occurrence data


# read in relevant BWG data -----------------------------------------------


data <-
  read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/species/cardoso_2008_speciesname.txt",
             sep="\t",header=TRUE,stringsAsFactors=FALSE)


trait.data <- read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/nicknames.FGs.csv",sep=",",
                         na.strings=c("NA","?"),header=TRUE,stringsAsFactors=FALSE)


# selecting predators -----------------------------------------------------

## first get the cardoso taxa
func.group <- trait.data[["predator.prey"]][match(data[["name"]],trait.data[["nickname"]])]

## then attach to our data
data.fg <- cbind(func.group,data)

## finally, select only the predators:
predator.matrix <- data.fg[which(data.fg[["func.group"]]=="predator"),]
### note that several taxa are listed as NA, which is not a problem because they are either rare or 
### definitely not predators.

# combining morphospecies and cleaning data -------------------------------

## delete the unused columns:
predator.matrix.sxs <- predator.matrix[,!names(predator.matrix)%in%c("func.group","name","realm")]
### (sxs because it is now a nice species x site matrix)

## combine corethrellids
## combine the corethrellids:
Corethr.spp <- grepl("Corethr*",predator.matrix.sxs[["X"]])
predator.matrix.sxs[["X"]][Corethr.spp] <- "Corethrella.sp"

## the "=" causes grief:

predator.matrix.sxs[["X"]] <- gsub(pattern="=",replacement="",x=predator.matrix.sxs[["X"]])

## using plyr, combine Corethrellids:
library(plyr)

predator.mat <- ddply(.data=predator.matrix.sxs,
                      .variables=.(X),.fun=colwise(sum))

write.csv(x=predator.mat,file="../data/reorganized_data/predator.cooccur.txt",row.names=FALSE)

# calculate correlations --------------------------------------------------

## for checking alignments
#write.csv(cbind(predtree$tip.label,pred.matrix.14spp[["X"]][alignments]),file="testtaxa.txt")

pred.matrix.14spp <- pred.matrix.14spp[alignments,-1]

## remove the long typed names and replace with tip labels:
rownames(pred.matrix.14spp) <- predtree$tip.label

str(pred.matrix.14spp)

## write and read to get numbers back!
write.csv(pred.matrix.14spp,file="predator.matrix.csv")

predator.matrix.numeric <- read.csv("predator.matrix.csv",row.names=1)

transpose.predator.matrix <- t(predator.matrix.numeric)

pred.abd.distance <- vegdist(predator.matrix.numeric,method="euclid")


pred.abd.cor <- cor(transpose.predator.matrix)

pdf("../figures/correlation_predator_dist.pdf")
plot(pred.abd.cor[lower.tri(pred.abd.cor)]~dist.tip.matrix[lower.tri(dist.tip.matrix)],pch="_")
lines(lowess(pred.abd.cor[lower.tri(pred.abd.cor)]~dist.tip.matrix[lower.tri(dist.tip.matrix)]))
dev.off()

pdf("../figures/euclid_predator_dist.pdf")
plot(pred.abd.distance~dist.tip.matrix[lower.tri(dist.tip.matrix)])
lines(lowess(pred.abd.distance~dist.tip.matrix[lower.tri(dist.tip.matrix)],delta=5))
dev.off()

pdf("../figures/beanplot_correlation_predator_dist.pdf")
beanplot(pred.abd.cor[lower.tri(pred.abd.cor)]~dist.tip.matrix[lower.tri(dist.tip.matrix)],pch="_")
#lines(lowess(pred.abd.cor[lower.tri(pred.abd.cor)]~dist.tip.matrix[lower.tri(dist.tip.matrix)]))
dev.off()

pdf("../figures/beanplot_euclid_predator_dist.pdf")
beanplot(pred.abd.distance~dist.tip.matrix[lower.tri(dist.tip.matrix)])
#lines(lowess(pred.abd.distance~dist.tip.matrix[lower.tri(dist.tip.matrix)],delta=5))
dev.off()

