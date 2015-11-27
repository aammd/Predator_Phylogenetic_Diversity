
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
    add_rownames %>% 
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
  
  answers %>% 
    ungroup %>% 
    mutate(species_pair = ifelse(species_pair == "andro_elong", "Leptagrion.andromache_Leptagrion.elongatum", 
                                 species_pair), 
           species_pair = ifelse(species_pair == "andro_leech", "Leptagrion.andromache_Hirudinidae", species_pair), 
           species_pair = ifelse(species_pair == "andro_tabanid", 
                                 "Leptagrion.andromache_Tabanidae.spA", species_pair), 
           species_pair = ifelse(species_pair == "elong_leech", 
                                 "Leptagrion.elongatum_Hirudinidae", species_pair), 
           species_pair = ifelse(species_pair == "elong_tabanid", 
                                 "Leptagrion.elongatum_Tabanidae.spA", species_pair), 
           species_pair = ifelse(species_pair == "leech_tabanid", 
                                 "Tabanidae.spA_Hirudinidae", species_pair)) %>% 
    left_join(.phylogenetic_distance)
}

make_fig_1 <- function(.metabolic_occur_phylo, .diet_overlap_phylo,
                       .experiment_phylo, .diet_predictions, .mytheme){
  
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
  
  make_nice_gg <- function(pred_info, .ylab= "Similarity\n(Pianka's index)"){
    pred_info %>%
      ggplot(aes(x = phylodistance, y = overlap, size = nspp)) + 
      geom_point(colour = "black", fill = "#00A08A",
                 shape  = 21, alpha = 0.6) +
      facet_wrap( ~ category, scales = "free_y", nrow = 3) + 
      xlab("Phylogenetic distance") +
      ylab(.ylab) +
      scale_size(range = c(3,9),name = "Number of\nresources")
    } 
  
  p1 <- distribution %>% 
    make_nice_gg + 
    .mytheme + 
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank())
  
  p2 <- diet %>% 
    make_nice_gg +
    geom_line(aes(x = phylodistance, y = pred_m2), 
              size = 0.5, data = .diet_predictions) +
    geom_line(aes(x = phylodistance, y = upper),
              size = 0.5, data = .diet_predictions, linetype = "dashed") +
    geom_line(aes(x = phylodistance, y = lower),
              size = 0.5, data = .diet_predictions, linetype = "dashed") + 
    .mytheme + 
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank())
    
  p3 <- make_nice_gg(exper, .ylab = "Community dissimilarity\n(Bray-Curtis) ") +
    .mytheme +
    coord_cartesian(ylim = c(0,1))
  
  g1 <- ggplotGrob(p1)
  g1[["grobs"]][[which(g1$layout$name=="guide-box")]][["grobs"]] <- NULL
  
  g3 <- ggplotGrob(p3)
  g3[["grobs"]][[which(g3$layout$name=="guide-box")]][["grobs"]] <- NULL

  grid.arrange(g1, p2, g3, ncol = 1)
}
