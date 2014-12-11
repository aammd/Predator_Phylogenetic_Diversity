library("dplyr")
library("magrittr")
library("reshape2")

source("../R.scripts/FUNCTIONS_predator_diversity.R")

# occurrance data -- metabolic capacity
metabolic  <- read.csv("../data/predator.cooccur.metabolic.txt",
                       stringsAsFactor=FALSE) %>%  tbl_df()

metabolic_distance <- paired_predator_pianka(pred_x_resource = metabolic,
                                             pred_colname = "Taxa",... =-Taxa)

write.csv(metabolic_distance, file = "../data/metabolic_distance.csv", row.names = FALSE)




