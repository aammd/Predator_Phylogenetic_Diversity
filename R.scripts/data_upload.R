## uploading the diet data to figshare:

fs_auth()
# id <- fs_create("Feeding trials of bromeliad invertebrates", "To test whether related predators eat similar prey, we fed prey to predators in laboratory feeding trials. We conducted 314 feeding trials of 10 predator taxa and 14 prey taxa between March and April 2011. We performed as many feeding trials as possible, however many combinations between rare taxa are still missing. 
# We tested 56 pairwise combinations.  Most trials were replicated at least five times, but the number of replicates ranged from 1 to 11. To conduct the trials, we placed
#           predators together with prey in a 50ml vial, with a stick for
#           substrate. The only exception was the tabanid larvae, which we
#           placed between two vertical surfaces to imitate the narrow space found in
#           bromeliad leaf axils (their preferred microhabitat, necessary for successful feeding).  Generally our trials contained a single predator and a
#           single prey individual, except in the case of very small prey (_Elpidium_ sp.)
#           or predators (_Monopelopia_ sp.) in which case we increased the density of the small taxon to five.  We recorded whether prey was consumed after 24 hours.")
# 
# Your article has been created! Your id number is 3978783

## get the data that we need: 

remake::dump_environment()
csvy::write_csvy(feeding_trials, "data/feeding_trials_metadata_blank.csvy",
                 quote = FALSE, row.names = FALSE)

## ... fill in data...

fs_upload(id, "data/feeding_trials.csvy")


## both phylogeny and tree data:

### put the tree data together

library(purrr)

## on second thought maybe this is not the right idea. This should probably go into the Supp Matt and we can get it later. 
tree_data <- dir("raw-data/TreeData/", full.names = TRUE) %>% 
  keep(~ stringr::str_detect(.x, "csv")) %>% 
  set_names() %>% 
  map_df(readr::read_csv, .id = "filename")

View(tree_data)


### Experimental data

pd_raw %>% 
  select(Id, treatment, eu, mass.g., org_fine_mass, total.surv, decomp, fine, X15N,  N, growth, contains("idae")) %>% 
  csvy::write_csvy("data/predator_diversity_experiment_metadata_blank.csvy",
                 quote = FALSE, row.names = FALSE)
