## R code for organizing predator co-occurrence data

data <-
  read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/species/cardoso_2008_speciesname.txt",
             sep="\t",header=TRUE,stringsAsFactors=FALSE)


trait.data <- read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/nicknames.FGs.csv",sep=",",
                         na.strings=c("NA","?"),header=TRUE,stringsAsFactors=FALSE)

## check the tree
#summary(predtree)
#predtree$edge
#predtree$edge.length

pdf("../figures/predatorPhylogenyCardoso2008.pdf")
plot(predtree)
dev.off()

## calculate taxonomic distance matrix:
dist.tip.matrix <- cophenetic.phylo(predtree)
class(dist.tip.matrix)
rownames(dist.tip.matrix)


## select only the predators:
## first get the cardoso taxa
func.group <- trait.data[["predator.prey"]][match(data[["name"]],trait.data[["nickname"]])]

## then attach to our data
data.fg <- cbind(func.group,data)

predator.matrix <- data.fg[which(data.fg[["func.group"]]=="predator"),]

## calculate correlations

dim(predator.matrix)

## first we must reorder the matrix so that it corresponds to the
## phylogeny:

predator.matrix[["X"]]
predtree$tip.label

## remove character columns all but the nicknames from the predator 
predator.matrix.nameonly <- predator.matrix[,!names(predator.matrix)%in%c("func.group","name","realm")]

## combine the corethrellids:
Corethr.spp <- grepl("Corethr*",predator.matrix.nameonly[["X"]])
no.corethr <- predator.matrix.nameonly[!Corethr.spp,]
sum.corethr <- colSums(predator.matrix[Corethr.spp,-c(1:4)])

pred.matrix.14spp <- rbind(no.corethr,c("Corethrella",sum.corethr))

cbind(predtree$tip.label,pred.matrix.14spp[["X"]])

alignments <- c(7,13,8,9,2,1,14,4,3,5,10,11,12,6)

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

