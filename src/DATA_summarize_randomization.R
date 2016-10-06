## summarize randomization test results
make_randomization_summary <- function(.rand.means){
  betternames <- c("elong + andro" = "Leptagrion.elongatum_Leptagrion.andromache",
                   "elong + tab" = "Leptagrion.elongatum_Tabanidae.spA",
                   "elong + leech" = "Leptagrion.elongatum_Hirudinidae")
  
  .rand.means %>% 
    # remove annoying X column
    #select(-X) %>%
    # melt, so that all responses can be summarized at the same time
    gather(response_var,value,-sp.pair) %>% 
    group_by(sp.pair,response_var) %>% 
    summarise(mean = mean(value),
              lower = quantile(value,probs=c(0.025)),
              upper = quantile(value,probs=c(0.975))
    ) %>%
    # sequence of increasing PD
    ungroup() %>%
    mutate(species_pair = betternames[sp.pair] %>% as.character)
}
  


