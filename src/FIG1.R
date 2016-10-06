
pd_exper_responses <- function(.pd, .phylogenetic_distance){
  
  ## first, get just the single-species treatments from the experiment
  pd_spp_resp <- .pd %>%
    filter(treatment %in% c("andro","elong","tabanid","leech")) %>%
    select(eu, Culicidae:Scirtidae) %>%
    group_by(eu)
  
  ## then, get these treatment names in a vector, named with the "eu" code:
  pred_species_trt <- .pd %>%
    filter(treatment %in% c("andro","elong","tabanid","leech")) %>%
    select(eu,treatment) %>% 
    {setNames(.[["treatment"]], .[["eu"]])} ## vector of predators, named with eu
  
  
  rns <- pd_spp_resp[[1]]
  spp_resp_mat <- as.matrix(pd_spp_resp[-1])
  rownames(spp_resp_mat) <- rns
  
  dist_resp <- vegan::vegdist(spp_resp_mat)
  
  df_dist_resp <- dist_resp %>% 
    as.matrix %>% 
    as.data.frame %>% 
    tibble::rownames_to_column() %>% 
    gather(colname, distval, -rowname) %>% 
    distinct
  
  ### filter out intraspecific variation
  answers <- df_dist_resp %>% 
    ## give species names back
    mutate(rowname = pred_species_trt[rowname],
           colname = pred_species_trt[colname]) %>% 
    filter(rowname != colname) %>% 
    ## group by species pairs. mean and sd
    unite(rowname, colname, col = species_pair) %>% 
    group_by(species_pair) %>% 
    summarize(overlap = mean(distval), sd_dist = sd(distval), nspp = n()) 
  
  combined_with_phyloinfo <- answers %>% 
    ungroup %>% 
    mutate(species_pair = ifelse(species_pair == "andro_elong", 
                                 "Leptagrion.andromache_Leptagrion.elongatum", 
                                 species_pair), 
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
    left_join(.phylogenetic_distance)
  
  combined_with_phyloinfo %>% 
    filter(!is.na(phylopred1))
}

make_fig_1 <- function(.metabolic_occur_phylo, .diet_overlap_phylo,
                       .experiment_phylo, .diet_predictions){
  
  distribution <- .metabolic_occur_phylo %>% 
    ungroup %>% 
    select(phylodistance,overlap) %>%
    mutate(category = "(a)", nspp = 2)
  
  diet <- .diet_overlap_phylo %>% 
    ungroup %>%
    select(phylodistance,overlap,nspp) %>%
    mutate(category = "(b)") %>%
    as.data.frame
  
  exper <- .experiment_phylo %>% 
    ungroup %>%
    select(phylodistance,overlap,nspp) %>%
    mutate(category = "(c)")
  
  list(diet, distribution, exper) %>% 
    map(~ .x %>% select(phylodistance, overlap, nspp, category)) %>% 
    bind_rows %>% 
    ggplot(aes(x = phylodistance, y = overlap, size = nspp)) + 
    geom_point(colour = "black", fill = "#00A08A",
               shape  = 21, alpha = 0.6) +
    facet_wrap( ~ category, nrow = 3) + 
    xlab("Phylogenetic distance") +
    ylab("Similarity (Pianka's index)") +
    scale_size(range = c(3,9),name = "Number of\nresources") +
    coord_cartesian(ylim = c(-0.08, 1.02)) +
    theme_minimal() +
    theme(strip.text.x = element_text(hjust = 0.05)) 
}
