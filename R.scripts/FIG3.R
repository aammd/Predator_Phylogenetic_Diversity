## Generate Fig 3 from summarized randomization test results

library("ggplot2")
library("dplyr")

summarize_randoms_phylo <- read.csv("../data/summarize_randoms_phylo.csv")

summarize_randoms_phylo %>% 
  filter(response_var == "survival") %>%
  ggplot(aes(x=phylodistance,y=mean)) + 
  geom_linerange(aes(ymin=lower, ymax=upper)) + 
  geom_point(size=6, shape = 21, colour = "black", fill = "#00A08A") + 
  ylab("Surviving prey species (nonadditive effect)") + 
  xlab("Time (Mya)") + 
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey") + 
  theme_minimal() +   
  theme(axis.ticks = element_blank(), text = element_text(size=20))

ggsave("../Figures/FIG_3.png", height = 21, width = 28, units = "cm")
