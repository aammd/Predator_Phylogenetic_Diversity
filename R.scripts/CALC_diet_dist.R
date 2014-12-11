library("dplyr")
library("magrittr")
library("reshape2")

source("../R.scripts/FUNCTIONS_predator_diversity.R")

## proportion eaten

prop.eaten <- read.csv("../data/proportion.eaten.csv",
                       stringsAsFactors = FALSE) %>%  tbl_df()

phylogenetic_distance  <- read.csv("../data/phylogenetic_distance.csv", stringsAsFactors = FALSE)

diet_overlap <- paired_predator_pianka(pred_x_resource = prop.eaten,
                                       pred_colname = "predator.names",
                                       -predator.names)

diet_overlap_phylo <- left_join(diet_overlap,phylogenetic_distance)

write.csv(diet_overlap_phylo, file = "../data/diet_overlap_phylo.csv", row.names = FALSE)
