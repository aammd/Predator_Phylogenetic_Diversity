library(dplyr)
library(tidyr)


col.defs <- c("Name of morphospecies taxa",
              "Unique identifier of bromeliad",
              "Abundance")

unit.defs <- c("Bezzia.sp1",
               "Bezzia.sp2",
               "Corethrella",
               "Dolichopodidae", 
               "Empididae.sp1",
               "Empididae.sp2",
               "Hirudinidae",
               "Leptagrion.andromache",
               "Leptagrion.elongatum",
               "Leptagrion.tan",
               "Monopelopia",
               "Tabanidae.spC", 
               "Tabanidae.spA",
               "Tabanidae.spB")


metabolic %>% 
  gather("brom", "abd", -Taxa) %>% 
  .[["Taxa"]] %>% 
  unique %>% 
  dput
