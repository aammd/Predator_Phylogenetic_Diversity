####### metabolic matrix ####
## we need to calculate two distance matrices:
## 1) metabolic capacity distance
## 2) phylogenetic distance

## This file does (2):

library("picante")
library("reshape2")
library("dplyr")
library("magrittr")

source("../R.scripts/FUNCTIONS_predator_diversity.R")

predtree_timetree_ages <- read.tree("../data/predator_tree_time.newick")
## metabolic matrix -- the "distance" between predator co-occurrence, measured as metabolism

####### phylogeny matrix ####
## Calculate distances
predtree_timetree_ages %>%
  cophenetic() %>%
  matrix_to_df() %>%
  select(phylopred1=Var1,
         phylopred2=Var2,
         phylodistance=value) %>%
  mutate(pairs_RH=paste0(phylopred1,"_",phylopred2),
         pairs_LH=paste0(phylopred2,"_",phylopred1)
  ) %>%
  melt(id.vars=c("phylopred1","phylopred2","phylodistance"),
       value.name="species_pair",
       variable.name="L_or_R") %>%
  write.csv(file = "../data/phylogenetic_distance.csv", row.names = FALSE)

