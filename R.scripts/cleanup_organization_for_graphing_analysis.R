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
# feeding trial data
foodweb <- read.csv("~/Dropbox/PhD/Brazil2011/data/reorganized_data/reorganized.feeding.trial.data.csv",
                    stringsAsFactors=FALSE)
# experimental data
pd <- read.csv("../data/reorganized_data/pd_exp_cleaned_data.csv")
# enriched leaves
enriched <- read.csv("../data/reorganized_data/enriched_leaves.csv")

## load in functions
source("../R.scripts/foodweb.fn.R")

# occurrence data ----------------------------------------------------------



# feeding trials ----------------------------------------------------------


# ecosystem function ------------------------------------------------------


###############################################
#       organization for analysis 


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
## first rename experiment predators names
rownames(experiment_predators_diet)[rownames(experiment_predators_diet)=="Green Tabanid"] <- "Tabanidae.spA"
rownames(experiment_predators_diet)[rownames(experiment_predators_diet)=="Leech"] <- "Hirudinidae"
rownames(experiment_predators_diet)[rownames(experiment_predators_diet)=="Leptagrion andromache"] <- "Leptagrion.andromache"
rownames(experiment_predators_diet)[rownames(experiment_predators_diet)=="Leptagrion elongatum"] <- "Leptagrion.elongatum"

## they should also be in the same sequence:
experiment_pred_diet_reordered <- experiment_predators_diet[match(rownames(experiment_predators_diet),rownames(phylodist)),]
## finally, calculate distance
distances <- vegdist(experiment_pred_diet_reordered,method='jaccard',diag=TRUE)
## make a distance matrix so lower.tri subsetting works
dist.mat <- as.matrix(distances)
