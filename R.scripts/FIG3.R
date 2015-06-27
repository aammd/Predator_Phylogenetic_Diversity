## Generate Fig 3 from summarized randomization test results

make_fig_3 <- function(.summarize_randoms_phylo){
  summarize_randoms_phylo %>% 
    filter(response_var == "survival") %>%
    ggplot(aes(x=phylodistance,y=mean)) + 
    geom_linerange(aes(ymin=lower, ymax=upper)) + 
    geom_point(size=6, shape = 21, colour = "black", fill = "#00A08A") + 
    ylab("Surviving prey species (nonadditive effect)") + 
    xlab("Time (Mya)") + 
    geom_hline(yintercept = 0, linetype = "dashed", colour = "grey") + 
    mytheme
}