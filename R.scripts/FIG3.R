## Generate Fig 3 from summarized randomization test results

make_fig_3 <- function(.summarize_randoms_phylo, .mytheme){
  .summarize_randoms_phylo %>% 
    filter(response == "total.surv") %>%
    ggplot(aes(x = phylodistance, y = value)) + 
    geom_linerange(aes(ymin = lower, ymax = upper)) + 
    geom_point(size = 6, shape = 21, colour = "black",
               fill = "#00A08A") + 
    .mytheme + 
    ylab("Non-additive effects of predaton on prey survival (number of prey individuals)") + 
    xlab("Phylogenetic distance between predators (Mya)") + 
    geom_hline(yintercept = 0, linetype = "dashed", colour = "grey")
}