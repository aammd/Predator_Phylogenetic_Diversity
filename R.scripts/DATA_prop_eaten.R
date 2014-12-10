## When calculating similiarity, we start with a predator (row) by resource (column) dataframe.
# pred x prey matrix, with cells = proportion eate

library("dplyr")
library("tidyr")

# feeding_trials %>% arrange(predator.names) %>% mutate(prop.eaten=eaten/number.trials)
feeding_trials <- read.csv("../data/reorganized.feeding.trial.data.csv",
                           stringsAsFactors=FALSE) %>%   tbl_df()



prop.eaten <- feeding_trials %>% 
  filter(!Prey.species %in% c("Leptagrion andromache <5mm",
                              "Leptagrion.elongatum")) %>% 
  filter(!predator.names %in% c("Phylloicus bromeliarum", "Dysticid")) %>%
  mutate(prop.eaten=eaten/number.trials) %>%
  arrange(predator.names,Prey.species) %>%
  select(-number.trials,-eaten) %>%
  spread(Prey.species,prop.eaten,fill = NA)
#dcast(predator.names~Prey.species,value.var="prop.eaten",fun.aggregate = mean)

write.csv(prop.eaten,"../data/proportion.eaten.csv")