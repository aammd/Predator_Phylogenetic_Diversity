### Distribution
## calculates the AIC values that appear in the supp matt.
library("dplyr")
metabolic_occur_phylo <- read.csv("../data/metabolic_occur_phylo.csv",
                                  stringsAsFactors = FALSE)
## load in functions
source("../R.scripts/FUNCTIONS_predator_diversity.R")


occur_aic <- metabolic_occur_phylo %>% 
  ungroup %>% 
  select(phylodistance,overlap) %>%
  fit_some_models

write.csv(occur_aic,file = "../data/distributional_similarity_AIC.csv", row.names = FALSE)
