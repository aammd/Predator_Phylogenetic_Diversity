## analysis and graphing of the food web data 

# read in functions and packages ------------------------------------------

source("foodweb.fn.R")
source("general.R")

library(ggplot2)
library(bipartite)
library(reshape)
library(vegan)

library(picante)
library(beanplot)



# read in data ------------------------------------------------------------

foodweb <- read.csv("~/Dropbox/PhD/Brazil2011/feeding.rearing/reorganized.feeding.trial.data.csv")

predtree <- read.tree("../TreeData/predators.arbit.ultrametric.phy")

# graph data --------------------------------------------------------------

## try the bipartite approach:
## data needs to be in a matrix

head(foodweb)
str(foodweb)

## I want a list of all predators:
trial.list <- split(foodweb,foodweb$predator.names)
sapply(trial.list,nrow)


## need predators as columns, herbivores as rows
foodweb.cast <- cast(data=foodweb,formula=Prey.species~predator.names,value="eaten.numeric",fun.aggregate=sum)


foodweb.matrix <- as.matrix(foodweb.cast[,-1])
dimnames(foodweb.matrix) <- list(foodweb.cast[[1]],names(foodweb.cast)[-1])
foodweb.matrix <- foodweb.matrix[,-ncol(foodweb.matrix)]  ## last column was an NA predator.

distances <- vegdist(t(foodweb.matrix),method='jaccard')
plot(distances)
str(distances)


phylodist <- cophenetic(predtree)
dimnames(phylodist)[[1]]
distances
aligns <- c(11,14,1,3,2,12,13)
phylo.selected <- phylodist[aligns,aligns]

dist.mat <- as.matrix(distances)
dist.mat.nosmall <- dist.mat[-5,-5]

pdf("~/Dropbox/PhD/Brazil2011/figures/dietSimilarityDistance.pdf")
plot(1:12,rep(c(1,0),times=6),ylim=c(-0.1,1.1),type="n",
     xlab="distance on tree",
     ylab="similarity in diet")
beanplot(dist.mat.nosmall[lower.tri(dist.mat.nosmall)]~phylo.selected[lower.tri(phylo.selected)],cut=1,add=TRUE,at=c(1,10,12),axes=FALSE)
dev.off()


visweb(foodweb.matrix)
plotweb(foodweb.matrix)

## should display only those which are in the experiment:
dimnames(foodweb.matrix)[[1]][c(1,2,3,5,7,8,9,9,11,12,14)]
dimnames(foodweb.matrix)[[2]][c(1,2,3,4)]

pdf("~/Dropbox/PhD/Brazil2011/figures/FoodwebExperimentSpecies.pdf")
par(cex=0.8)
plotweb(y.width.low=0.05,y.width.high=0.05,ybig=1,
        foodweb.matrix[c(1,2,3,5,7,8,9,9,11,12,14),c(1,2,3,4)])
dev.off()
## the PROBLEM is that there are 0s and there are NAs and I want to have a means
## of displaying each
pdf("../Brazil2011/figures/foodwebVisweb.pdf")
visweb(labsize=0.4,
       foodweb.matrix[c(1,2,3,5,7,8,9,9,11,12,14),c(1,2,3,4)])
dev.off()

example(visweb)

## or you could look for compartments!
visweb(type="diagonal",foodweb.matrix[c(1,2,3,5,7,8,9,9,11,12,14),c(1,2,3,4)])


### older graphs -- may not still work!


pngPPT("Cardoso food web.png")
picture(feeding)
dev.off()

feeding$lept <- factor(c("not","lept")[(as.numeric(feeding$Predator==levels(feeding$Predator)[6]|
                                                     feeding$Predator==levels(feeding$Predator)[7]|
                                                     feeding$Predator==levels(feeding$Predator)[8]|
                                                     feeding$Predator==levels(feeding$Predator)[9])
                                        +1)
                                       ]
)

test <- subset(feeding,feeding$lept=="not")
test$Predator <- factor(test$Predator)
test$Prey <- factor(test$Prey)

pngPPT("non.lept.png")
picture(test,spread=2)
dev.off()

test1 <- subset(feeding,feeding$lept=="lept")
test1$Predator <- factor(test1$Predator)
test1$Prey <- factor(test1$Prey)

pngPPT("lept.png")
picture(test1,spread=3)
dev.off()
