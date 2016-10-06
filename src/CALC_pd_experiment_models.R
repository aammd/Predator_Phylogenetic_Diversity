#dropping a record that seems to have been 90% decomposed!
drop_outlier <- function(.pd){
  transform(.pd, decomp = ifelse(decomp>0.7, NA, decomp))
}

experiment_and_phylo <- function(.pd, .phylogenetic_distance){
  .pd %>% 
    select(treatment, total.surv, decomp, fine, N, growth) %>%
    mutate(treatment = treatment %>% 
             equals("control") %>% 
             ifelse(paste0(treatment,
                           seq_along(treatment)),
                    treatment)) %>% 
    gather(key = response, value = resp_val, -treatment) %>%
    mutate(ispred = ifelse(grepl("control[0-9]+", treatment), "absent", "present"),
           npred = ifelse(grepl(" \\+ ", treatment), "two", "one"),  
           # note this mislabels control; remember to filter it
           species_pair = ifelse(treatment == "elong + andro",
                                 "Leptagrion.andromache_Leptagrion.elongatum", NA),
           species_pair = ifelse(treatment == "elong + leech",
                                 "Leptagrion.elongatum_Tabanidae.spA", species_pair),
           species_pair = ifelse(treatment == "elong + tab",
                                 "Leptagrion.elongatum_Tabanidae.spA", species_pair)) %>%
    left_join(.phylogenetic_distance)
}


# trtnames <- c("total.surv" = "Total prey survival",
#               "fine" = "FPOM (g)",
#               "decomp" = "Decomposition (g)",
#               "growth" = "Bromeliad growth")

mean_na <- function(x) mean(x, na.rm = TRUE)


make_modlist <- function(pd2){
  list(
    presence = pd2 %>% 
      select(treatment, response, resp_val, ispred) %>%
      group_by(ispred, treatment, response) %>% 
      summarise(mean = mean_na(resp_val)) %>% 
      group_by(response) %>% 
      do(m = lm(mean ~ ispred, data = .)),
    identity = pd2 %>% 
      filter(npred == "one" & ispred != "absent") %>%
      select(treatment, response, resp_val, ispred) %>% 
      group_by(response) %>%
      do(m = lm(resp_val ~ treatment, data = .)),
    number = pd2 %>% 
      filter(ispred == "present") %>%
      select(treatment, response, resp_val, npred) %>%
      group_by( response, npred, treatment) %>%
      summarise(mean = mean_na(resp_val))  %>% 
      group_by(response) %>%
      do(m = lm(mean ~ npred, data = .)),
    phylodist = pd2 %>%
      filter(npred == "two") %>%
      group_by(response) %>%
      do(m = lm(resp_val ~ phylodistance, data = .))
  )
}