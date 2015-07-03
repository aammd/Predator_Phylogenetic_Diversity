make_nonadditive_randomization <- function(experiment_data){
  
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
  left_join(true_means, means_boot_ci)
}