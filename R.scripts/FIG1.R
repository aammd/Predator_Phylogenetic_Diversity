
pd_exper_responses <- function(.pd, .phylogenetic_distance){
  .pd %>%
    filter(treatment %in% c("andro","elong","tabanid","leech")) %>%
    select(treatment, Culicidae:Scirtidae) %>%
    group_by(treatment) %>%
    summarise_each(funs(mean)) %>%
    paired_predator_pianka(pred_colname = "treatment", ... = -treatment) %>%
    ungroup %>%
    mutate(species_pair = ifelse(species_pair == "andro_elong",
                                 "Leptagrion.andromache_Leptagrion.elongatum",
                                 species_pair),
           species_pair = ifelse(species_pair == "andro_leech",
                                 "Leptagrion.andromache_Hirudinidae",
                                 species_pair),
           species_pair = ifelse(species_pair == "andro_tabanid",
                                 "Leptagrion.andromache_Tabanidae.spA",
                                 species_pair),
           species_pair = ifelse(species_pair == "elong_leech",
                                 "Leptagrion.elongatum_Hirudinidae",
                                 species_pair),
           species_pair = ifelse(species_pair == "elong_tabanid",
                                 "Leptagrion.elongatum_Tabanidae.spA",
                                 species_pair),
           species_pair = ifelse(species_pair == "leech_tabanid",
                                 "Tabanidae.spA_Hirudinidae",
                                 species_pair)) %>%
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
    
  p3 <- make_nice_gg(exper, .ylab = "Community similarity") +
    .mytheme 
  
  g1 <- ggplotGrob(p1)
  g1[["grobs"]][[which(g1$layout$name=="guide-box")]][["grobs"]] <- NULL
  
  g3 <- ggplotGrob(p3)
  g3[["grobs"]][[which(g3$layout$name=="guide-box")]][["grobs"]] <- NULL

  grid.arrange(g1, p2, g3, ncol = 1)
}
