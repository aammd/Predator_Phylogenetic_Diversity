library("dplyr")
library("magrittr")
library("reshape2")

source("../R.scripts/FUNCTIONS_predator_diversity.R")

# occurrance data -- metabolic capacity
metabolic  <- read.csv("../data/predator.cooccur.metabolic.txt",
                       stringsAsFactor=FALSE) %>%  tbl_df()

phylogenetic_distance  <- read.csv("../data/phylogenetic_distance.csv")


metabolic_distance <- paired_predator_pianka(pred_x_resource = metabolic,
                                             pred_colname = "Taxa",... =-Taxa)

metabolic_occur_phylo <-  left_join(metabolic_distance, phylogenetic_distance)

write.csv(metabolic_occur_phylo, file = "../data/metabolic_occur_phylo.csv", row.names = FALSE)




