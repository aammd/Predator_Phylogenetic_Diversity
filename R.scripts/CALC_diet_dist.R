library("dplyr")
library("magrittr")
library("reshape2")

source("../R.scripts/FUNCTIONS_predator_diversity.R")

## proportion eaten

prop.eaten <- read.csv("../data/proportion.eaten.csv",
                       stringsAsFactor=FALSE) %>%  tbl_df()

diet_overlap <- paired_predator_pianka(pred_x_resource = prop.eaten,
                                       pred_colname = "predator.names",
                                       -predator.names)

write.csv(diet_overlap, file = "../data/diet_overlap.csv", row.names = FALSE)
