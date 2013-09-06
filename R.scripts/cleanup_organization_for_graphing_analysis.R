## this file takes all the FINISHED datasets and prepares them for publication
## in other words, the combined tree data, the community data, the experiment data and simulation results etc.


# loading packages and data -----------------------------------------------
## load packages
library(ggplot2)
library(bipartite)
library(reshape)
library(vegan)
library(picante)
library(beanplot)

## load in data
# phylogenetic data
source("../R.scripts/phylogeny.R") 

# occurrance data
occur <- read.csv("~/Dropbox/PhD/Brazil2011/data/reorganized_data/predator.cooccur.txt",stringsAsFactor=FALSE)
metabolic  <- read.csv("~/Dropbox/PhD/Brazil2011/data/reorganized_data/predator.cooccur.metabolic.txt",stringsAsFactor=FALSE)

# feeding trial data
foodweb <- read.csv("~/Dropbox/PhD/Brazil2011/data/reorganized_data/reorganized.feeding.trial.data.csv",
                    stringsAsFactors=FALSE)
# experimental data
pd <- read.csv("../data/reorganized_data/pd_exp_cleaned_data.csv")
# enriched leaves -- ie just the N data for the detritus we put in.
enriched <- read.csv("../data/reorganized_data/enriched_leaves.csv")

# phylogeny data
source("../R.scripts/phylogeny.R")

## load in functions
source("../R.scripts/foodweb.fn.R")

# distance matrix calculation ----------------------------------------------------------

## combine by names, then do distances:
## metabolic matrix
metabolic.matrix <- metabolic[-1]
dimnames(metabolic.matrix)[[1]] <- metabolic[,1]
pred.abd.distance <- vegdist(metabolic.matrix,method="euclid")
pred_abd_matrix <- as.matrix(pred.abd.distance)
#occurdist_allpred <- data.frame(X=rownames(pred_abd_matrix),pred_abd_matrix)
metabolic_mat <- as.matrix(metabolic.matrix)
pred_cor_matrix <- cor(t(metabolic_mat))

## phylogeny matrix
allpred.distance.matrix <- cophenetic(predtree_timetree_ages)
where_in_phylo <- match(rownames(pred_abd_matrix),rownames(allpred.distance.matrix))
pred_phylo_matrix <- allpred.distance.matrix[where_in_phylo,where_in_phylo]

#Xlab <- expression(paste("Phylogenetic distance (mean age of common ancestor,10"^"6",")"))

#pdf("euclid_metabolic.pdf")
plot(pred_abd_matrix[lower.tri(pred_abd_matrix)]~jitter(pred_phylo_matrix[lower.tri(pred_phylo_matrix)],amount=5),
     xlab="phylogenetic distance",ylab="euclidian distance between total metabolic capacity")
#dev.off()

## phylogeny matrix
allpred.distance.matrix <- cophenetic(predtree_timetree_ages)
where_in_phylo <- match(rownames(pred_cor_matrix),rownames(allpred.distance.matrix))
pred_phylo_matrix <- allpred.distance.matrix[where_in_phylo,where_in_phylo]

#Xlab <- expression(paste("Phylogenetic distance (mean age of common ancestor,10"^"6",")"))

#pdf("cor_metabolic.pdf")
plot(pred_cor_matrix[lower.tri(pred_cor_matrix)]~jitter(pred_phylo_matrix[lower.tri(pred_phylo_matrix)],amount=10),
     xlab="phylogenetic distance",ylab="correlation between total metabolic capacity")
#dev.off()

summary(lm(pred_cor_matrix[lower.tri(pred_cor_matrix)]~pred_phylo_matrix[lower.tri(pred_abd_matrix)]))


mantel.test(pred_phylo_matrix,pred_cor_matrix)



# total biomass per bromeliad

mantel.test(allpred.distance.matrix,predator.occur.matrix,nperm=500)

# feeding trials ----------------------------------------------------------

# Check for TRUE ZEROS in cast matrix.

# trial.list <- split(foodweb,foodweb$predator.names)
# sapply(trial.list,nrow)
## need predators as columns, herbivores as rows
foodweb.cast <- cast(data=foodweb,formula=Prey.species~predator.names,value="eaten.numeric",fun.aggregate=sum)
# remove species names
foodweb.matrix <- as.matrix(foodweb.cast[,-1])
# have better names
dimnames(foodweb.matrix) <- list(foodweb.cast[[1]],names(foodweb.cast)[-1])
foodweb.matrix <- foodweb.matrix[,-ncol(foodweb.matrix)]  ## last column was an NA predator.
# make the distance matrix -- with the jaccard index?
## start by getting the predators from the foodweb data that are actually in the experiment:
location_exp_predators <- which(dimnames(foodweb.matrix)[[2]]%in%c("Green Tabanid","Leech","Leptagrion andromache","Leptagrion elongatum"))
## vegdist will calculate differences among rows, so transpose
experiment_predators_diet <- t(foodweb.matrix[,location_exp_predators])
## better to rename and reorder to resemble output of cophenetic
## phylogenetic distances:
phylodist <- cophenetic(predators.in.exp)
## they should also be in the same sequence:
experiment_pred_diet_reordered <- experiment_predators_diet[match(rownames(experiment_predators_diet),rownames(phylodist)),]
## finally, calculate distance
distances <- vegdist(experiment_pred_diet_reordered,method='jaccard',diag=TRUE)
## make a distance matrix so lower.tri subsetting works
dist.mat <- as.matrix(distances)

# ecosystem function ------------------------------------------------------



