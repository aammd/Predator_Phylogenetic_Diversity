
library("dplyr")
library("magrittr")
library("reshape2")
library("ggplot2")

source("../R.scripts/FUNCTIONS_predator_diversity.R")

## ggplot2 theme
mytheme <- theme_bw()


phylogenetic_distance  <- read.csv("../data/phylogenetic_distance.csv", stringsAsFactors = FALSE)


metabolic_occur_phylo <- read.csv("../data/metabolic_occur_phylo.csv",
                                  stringsAsFactors = FALSE)

diet_overlap_phylo <- read.csv("../data/diet_overlap_phylo.csv",
                               stringsAsFactors=FALSE) %>%   tbl_df()

# experimental data
pd <- read.csv("../data/pd_exp_cleaned_data.csv",
               stringsAsFactors=FALSE) %>%   tbl_df()


diet_predictions <- read.csv("../data/diet_predictions.csv", stringsAsFactors = FALSE)

distribution <- metabolic_occur_phylo %>% 
  ungroup %>% 
  select(phylodistance,overlap) %>%
  mutate(category = "(a)", nspp = 2)

diet <- diet_overlap_phylo %>% 
  ungroup %>%
  select(phylodistance,overlap,nspp) %>%
  mutate(category = "(b)") %>%
  as.data.frame

exper <- pd %>%
  filter(treatment %in% c("andro","elong","tabanid","leech")) %>%
  select(treatment, Culicidae:Scirtidae) %>%
  group_by(treatment) %>%
  summarise_each(funs(mean)) %>%
  paired_predator_pianka(pred_colname = "treatment", ... = -treatment) %>%
  ungroup %>%
  mutate(species_pair = ifelse(species_pair == "andro_elong",
                               "Leptagrion.andromache_Leptagrion.elongatum", species_pair),
         species_pair = ifelse(species_pair == "andro_leech",
                               "Leptagrion.andromache_Hirudinidae", species_pair),
         species_pair = ifelse(species_pair == "andro_tabanid",
                               "Leptagrion.andromache_Tabanidae.spA", species_pair),
         species_pair = ifelse(species_pair == "elong_leech",
                               "Leptagrion.elongatum_Hirudinidae", species_pair),
         species_pair = ifelse(species_pair == "elong_tabanid",
                               "Leptagrion.elongatum_Tabanidae.spA", species_pair),
         species_pair = ifelse(species_pair == "leech_tabanid",
                               "Tabanidae.spA_Hirudinidae", species_pair)) %>%
  left_join(phylogenetic_distance) %>% 
  ungroup %>%
  select(phylodistance,overlap,nspp) %>%
  mutate(category = "(c)")

rbind(distribution, diet, exper) %>%
  ggplot(aes(x = phylodistance, y = overlap, size = nspp)) + 
  geom_point(colour = "black", fill = "#00A08A",
             shape  = 21, alpha = 0.6) +
  facet_wrap( ~ category, scales = "free_y", nrow = 3) + 
  xlab("Phylogenetic distance") + 
  ylab("Similarity (Pianka's index)") + 
  scale_size(range = c(3,9),name = "Number of\nprey") +
  geom_line(aes(x = phylodistance, y = pred_m2), 
            size = 0.5, data = diet_predictions) +
  geom_line(aes(x = phylodistance, y = upper),
            size = 0.5, data = diet_predictions, linetype = "dashed") +
  geom_line(aes(x = phylodistance, y = lower),
            size = 0.5, data = diet_predictions, linetype = "dashed") + 
  mytheme + theme(strip.text = element_text(hjust = 0.01),
                  strip.background = element_blank())

ggsave("../Figures/FIG_1.pdf", height = 6, width = 6, units = "in")