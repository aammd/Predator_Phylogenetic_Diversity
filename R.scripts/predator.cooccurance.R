## R code for calculating the co-occurance of predators

library(picante)

predtree <- read.tree("../TreeData/predators.arbit.ultrametric.phy")

summary(predtree)

predtree$edge
predtree$edge.length

plot(predtree)

dist.tip.matrix <- cophenetic.phylo(predtree)
class(dist.tip.matrix)
rownames(dist.tip.matrix)


data <-
  read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/species/cardoso_2008_speciesname.txt",
             sep="\t",header=TRUE,stringsAsFactors=FALSE)


trait.data <- read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/nicknames.FGs.csv",sep=",",
na.strings=c("NA","?"),header=TRUE,stringsAsFactors=FALSE)

trait.data[["nickname"]]


func.group <- trait.data[["predator.prey"]][match(data[["name"]],trait.data[["nickname"]])]

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

write.csv(pred.matrix.14spp,file="predator.matrix.csv")

predator.matrix.numeric <- read.csv("predator.matrix.csv",row.names=1)

transpose.predator.matrix <- t(predator.matrix.numeric)

pred.abd.distance <- vegdist(predator.matrix.numeric,method="euclid")


pred.abd.cor <- cor(transpose.predator.matrix)

plot(pred.abd.cor[lower.tri(pred.abd.cor)]~dist.tip.matrix[lower.tri(dist.tip.matrix)],pch="-")
lines(lowess(pred.abd.cor[lower.tri(pred.abd.cor)]~dist.tip.matrix[lower.tri(dist.tip.matrix)]))

library(beanplot)
beanplot(pred.abd.distance~dist.tip.matrix[lower.tri(dist.tip.matrix)],pch="-")
lines(lowess(pred.abd.distance~dist.tip.matrix[lower.tri(dist.tip.matrix)],delta=5))

## Right now the rownames are alright -- the represent position in the
## original data.  but this is better
row.names(predator.matrix.nameonly) <- predator.matrix.nameonly[["name"]]
## now remove the 'name' column
predator.matrix.numeric <- predator.matrix.nameonly[,-1]
pred.cor <- cor(t(predator.matrix.numeric))

plot(pred.cor[lower.tri(pred.cor)])





pred.tree <- read.tree("../TreeData/predator.taxonomic.phylogeny.phy")

plot(pred.tree)

write.nexus(pred.tree,file="../TreeData/predators.nex")

predtree.edited <- read.nexus("../TreeData/predators.cleared2.nex")
predtree.foo <- read.tree("../TreeData/predators.cleared2.phy")

rea

plot.phylo(predtree.foo)

tree<-read.tree(text=write.tree(predtree.foo))

plot.phylo(tree)

##cophenetic(predtree.edited)

predtree.edited
predtree.edited$tip.label
predtree.edited$edge.length

class(predtree.edited)
reord <- reorder(predtree.edited)

plot(reord)

head(trait.data)
head(data)
data$name %in% 

data[[1]]


insecttree$tip.label
