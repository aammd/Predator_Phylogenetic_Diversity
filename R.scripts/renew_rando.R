## Diane and I decided to take the average of each group 
## after randomizing, and _then_ to take the subtraction. 
## This similar to the way an effect size would be
## calculated on raw data, and we use bootstrapping to
## create confidence intervals

make_nonadditive_bootCI <- function(experiment_data){
  
  ## select responses and gather these into a single column
  long_responses <- experiment_data %>% 
    tbl_df %>% 
    select(treatment, X15N, total.surv, fine, decomp, growth) %>% 
    gather(response, value, -treatment) %>% 
    ## groups contain all 5 replicates
    group_by(response, treatment)
  
  ## define a functional sequence to calcuate means, then differences
  calc_means_difference <- . %>% 
    summarise(mean_resp = failwith(NA, mean)(value, na.rm = TRUE)) %>%
    mutate(treatment = gsub(" \\+ ", "_", treatment)) %>%
    spread(treatment, mean_resp) %>% 
    mutate(andro_non = (andro + elong)/2 - elong_andro,
           tab_non = (tabanid + elong)/2 - elong_tab,
           leech_non = (leech + elong)/2 - elong_leech) %>% 
    select(response, ends_with("_non")) %>% 
    gather(nonadd, value, -response) %>% 
    arrange(response)
  
  ## calculate these values for observed data
  obs_means <- long_responses %>% 
    calc_means_difference
  
  ## bootstrap
  randomized_means <- replicate(500, {
    long_responses  %>% 
      sample_n(5, TRUE) %>% 
      calc_means_difference
  }, simplify = FALSE) %>% 
    unnest(col = "rep")
  
  ## take quantiles
  means_boot_ci <- randomized_means %>% 
    group_by(response, nonadd) %>% 
    summarize(upper = quantile(value, prob = .975, na.rm = TRUE),
              lower = quantile(value, prob = .025, na.rm = TRUE))
  
  ## combine with obseved means
  left_join(obs_means, means_boot_ci)
}


## we need to relevel this so it can be merged and also used
## for the FIG3.R function
relevel_nonadd_boot <- function(nonadd_means){
  new_combo_names <- c("andro_non" = "Leptagrion.elongatum_Leptagrion.andromache",
                       "leech_non" = "Leptagrion.elongatum_Hirudinidae",
                       "tab_non" = "Leptagrion.elongatum_Tabanidae.spB") 
  
  nonadd_means %>% 
    mutate(species_pair = new_combo_names[nonadd])
    
}