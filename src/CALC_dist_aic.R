make_dist_sim_AIC <- function(.metabolic_occur_phylo){
  .metabolic_occur_phylo %>% 
    ungroup %>% 
    select(phylodistance,overlap) %>%
    fit_some_models
}