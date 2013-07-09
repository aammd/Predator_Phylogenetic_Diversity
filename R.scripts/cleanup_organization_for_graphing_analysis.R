## this file takes all the FINISHED datasets and prepares them for publication
## in other words, the combined tree data, the community data, the experiment data and simulation results etc.

## load packages
library(ggplot2)
library(bipartite)
library(reshape)
library(vegan)

library(picante)
library(beanplot)

## load in data
foodweb <- read.csv("~/Dropbox/PhD/Brazil2011/data/reorganized_data/reorganized.feeding.trial.data.csv",
                    stringsAsFactors=FALSE)
predtree <- read.tree("../data/TreeData/predators.arbit.ultrametric.phy")
pd <- read.csv("../data/reorganized_data/pd_exp_cleaned_data.csv")

## load in functions
source("../R.scripts/foodweb.fn.R")

## just the predators in the experiment:

insects_to_leeches <- mean(read.csv("../data/TreeData//insects.to.leeches.csv")$Time)
odonata_tabanid <- mean(read.csv("../data/TreeData/odonata-Tabanidae.csv")$Time)
cerato_chiro <- mean(read.csv("../data/TreeData/Ceratopogonidae_Chironomidae.csv")$Time)
culicidae_chironomidae <- mean(read.csv("../data/TreeData/CulicidaetoChironomidae.csv")$Time)
empid_dolicho <- mean(read.csv("../data/TreeData/empididaeDolichopodidae.csv")$Time)
dolicho_tabanid <- mean(read.csv("../data/TreeData/dolicho_tabanid.csv")$Time)
diptera <- mean(read.csv("../data/TreeData/tabanidae_culidicae_ie_Diptera.csv")$Time)

plot(predtree)
# str(pred_exp_phylo)

## now a phylogenetic tree for all predators in the experiment:
str(predtree)
predtree_timetree_ages <- predtree
## we can alter the edge lengths one at a time
## first the trouble of knowing what edge to modify.
## use tip.label and node.label
## change 15 years for all leptagrion
change_edgelength <- function(desc_name_regex,ancest_name_regex,age,tree=predtree_timetree_ages){
  tip_and_node <- c(tree$tip.label,tree$node.label)
  location_ancestor <- which(grepl(ancest_name_regex,tip_and_node))
  location_descendent <- which(grepl(desc_name_regex,tip_and_node))
  edges <- which(tree$edge[,1]%in%location_ancestor&tree$edge[,2]%in%location_descendent)
  tree$edge.length[edges] <- age
  tree
}
## set the age of Leptagrion to the age of enallagama
predtree_timetree_ages <- change_edgelength(desc_name_regex="Lept.",ancest_name_regex="Leptagrion",age=15,tree=predtree_timetree_ages)
## subtract this distance from the age of the common ancestor of all pterygota::
predtree_timetree_ages <- change_edgelength(desc_name_regex="Leptagrion",ancest_name_regex="Pterygota",age=odonata_tabanid-15,tree=predtree_timetree_ages)
## bezzia -- for now give it 15 as well
predtree_timetree_ages <- change_edgelength(desc_name_regex="Bezzia.",ancest_name_regex="Bezzia",age=15,tree=predtree_timetree_ages)
## bezzia to monopelopia -- ceratopogonid to chironomid
predtree_timetree_ages <- change_edgelength(desc_name_regex="Monopelopia",ancest_name_regex="Chironomoidea",age=cerato_chiro,tree=predtree_timetree_ages)
## same for Bezzia
predtree_timetree_ages <- change_edgelength(desc_name_regex="Bezzia",ancest_name_regex="Chironomoidea",age=cerato_chiro-15,tree=predtree_timetree_ages)
# Corethrella is descended from the Culicimorpha, as are Bezzia & monopelopia
predtree_timetree_ages <- change_edgelength(desc_name_regex="Corethrella",ancest_name_regex="Culicimorpha",age=culicidae_chironomidae,tree=predtree_timetree_ages)
# just need the branch from Chironomoidea to the ancestor Culicimorpha
predtree_timetree_ages <- change_edgelength(desc_name_regex="Chironomoidea",ancest_name_regex="Culicimorpha",age=culicidae_chironomidae-cerato_chiro,tree=predtree_timetree_ages)
# let's just say Empididae also is 15 million
predtree_timetree_ages <- change_edgelength(desc_name_regex="Empididae.",ancest_name_regex="Empididae",age=15,tree=predtree_timetree_ages)
## time tree for difference between empididae and dolicho:
predtree_timetree_ages <- change_edgelength(desc_name_regex="Dolichopodidae",ancest_name_regex="Empidoidea",age=empid_dolicho,tree=predtree_timetree_ages)
predtree_timetree_ages <- change_edgelength(desc_name_regex="Empididae",ancest_name_regex="Empidoidea",age=empid_dolicho-15,tree=predtree_timetree_ages)
## dolichopodidae to tabanidae.  is an internal node, so requires some subtraction:
## again, set Tabanids to 15?
predtree_timetree_ages <- change_edgelength(desc_name_regex="Tabanidae.",ancest_name_regex="Tabanidae",age=20,tree=predtree_timetree_ages)
## here common ancestor is Brachycera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Tabanidae",ancest_name_regex="Brachycera",age=dolicho_tabanid-20,tree=predtree_timetree_ages)
## and the difference to common ancestor of dolich&Empidiae to Brachycera:
predtree_timetree_ages <- change_edgelength(desc_name_regex="Empidoidea",ancest_name_regex="Brachycera",age=dolicho_tabanid-empid_dolicho,tree=predtree_timetree_ages)
## Brachycera Diptera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Brachycera",ancest_name_regex="Diptera",age=diptera-dolicho_tabanid,tree=predtree_timetree_ages)
# culicimorpha to diptera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Culicimorpha",ancest_name_regex="Diptera",age=diptera-culicidae_chironomidae,tree=predtree_timetree_ages)
# now add the age of pterygota to diptera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Diptera",ancest_name_regex="Pterygota",age=odonata_tabanid-diptera,tree=predtree_timetree_ages)
# finally, the leeches:
predtree_timetree_ages <- change_edgelength(desc_name_regex="Pterygota",ancest_name_regex="Protostomia",age=insects_to_leeches-odonata_tabanid,tree=predtree_timetree_ages)
## LEECHES themselves are simple
predtree_timetree_ages <- change_edgelength(desc_name_regex="Hirudinidae",ancest_name_regex="Protostomia",age=insects_to_leeches,tree=predtree_timetree_ages)

plot(predtree_timetree_ages)


mat <- matrix(1,nrow=4)
rownames(mat) <- c("Leptagrion.andromache","Leptagrion.elongatum","Tabanidae.spA","Hirudinidae")
predators.in.exp <- prune.sample(phylo=predtree_timetree_ages,samp=t(mat))
plot(predators.in.exp)
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
phylodist <- cophenetic(pred_exp_phylo)
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
