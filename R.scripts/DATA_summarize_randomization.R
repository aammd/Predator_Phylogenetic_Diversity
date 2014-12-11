## summarize randomization test results

library("dplyr")
library("tidyr")

rand.means <- read.csv("../raw-data/predator.div.experiment/randomizations.group.means.csv") %>%
  tbl_df()

phylogenetic_distance  <- read.csv("../data/phylogenetic_distance.csv", stringsAsFactors = FALSE)

betternames <- c("elong + andro" = "Leptagrion.elongatum_Leptagrion.andromache",
                 "elong + tab" = "Leptagrion.elongatum_Tabanidae.spA",
                 "elong + leech" = "Leptagrion.elongatum_Hirudinidae")

rand.means %>% 
  # remove annoying X column
  select(-X) %>%
  # melt, so that all responses can be summarized at the same time
  gather(response_var,value,-sp.pair) %>% 
  group_by(sp.pair,response_var) %>% 
  summarise(mean=mean(value),
            lower=quantile(value,probs=c(0.025)),
            upper=quantile(value,probs=c(0.975))
  ) %>%
  # sequence of increasing PD
  ungroup() %>%
  mutate(species_pair = betternames[sp.pair] %>% as.character) %>%
  left_join(phylogenetic_distance) %>%
  write.csv("../data/summarize_randoms_phylo.csv")
  


