
# "https://zenodo.org/record/168039/files/SrivastavaLab/cardoso2008-v1.0.0.zip"

read_published_zenodo <- function(zen_url) {
  tf <- tempfile()
  
  curl::curl_download(zen_url, tf)
  
  unzip(tf)
  
  td <- tempdir()
  
  unzip(tf, exdir = td)
  
  list.files(td)
  
  cardoso08files <- dir(td, full.names = TRUE) %>% 
    keep(~ str_detect(.x, "Srivas")) %>% 
    dir(full.names = TRUE) %>% 
    keep(~ str_detect(.x, "/data")) %>% 
    dir(full.names = TRUE) %>%
    set_names(basename(.)) %>% 
    map(read_csv)
  
  return(cardoso08files)
}

create_metabolic_matrix <- function(.cardoso08files){
  
  ## read from CSVs
  
  abds<- .cardoso08files$abundance.csv
  
  env <- .cardoso08files$environmental_variables.csv
  
  macroinverts <- .cardoso08files$macroinvertebrate_names_mass.csv
  
  abds %>% 
    left_join(macroinverts) %>% 
    group_by(morphospecies, Bromeliad) %>% 
    nest %>% 
    mutate(tot = map_dbl(data, ~ sum(.x[["abundance"]]))) %>% 
    glimpse
  
  
  prednames <- .cardoso08files$predator_names.csv
  ## check names
  
  # abds %>% 
  #   left_join(macroinverts) %>% 
  #   left_join(prednames) %>% 
  #   select(field_name, morphospecies, Taxa) %>% 
  #   ## drop any without matches (ie predators)
  #   filter(!is.na(Taxa)) %>% 
  #   distinct %>% 
  #   View
  
  occur_data <- abds %>% 
    left_join(macroinverts) %>% 
    left_join(prednames) %>% 
    ## drop any without matches (ie predators)
    filter(!is.na(Taxa))  %>%
    select(Bromeliad, Taxa, average_percapita_biomass, abundance) %>% 
    group_by(Taxa, Bromeliad)
  
  
  occur_data %>% 
    mutate(metabolic_cap = (average_percapita_biomass * abundance) ^ 0.69) %>% 
    summarize(total_metabolic_cap = sum(metabolic_cap)) %>% 
    ungroup %>% 
    complete(Taxa, Bromeliad, fill = list(total_metabolic_cap = 0)) %>% 
    spread(Bromeliad, total_metabolic_cap, fill = 0)
}

