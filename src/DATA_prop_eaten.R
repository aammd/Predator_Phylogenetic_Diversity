## When calculating similiarity, we start with a predator (row) by resource (column) dataframe.
# pred x prey matrix, with cells = proportion eate

calc_prop_eaten <- function(.feeding_trials){
  prop.eaten <- .feeding_trials %>% 
    filter(!Prey.species %in% c("Leptagrion andromache <5mm",
                                "Leptagrion.elongatum")) %>% 
    filter(!predator.names %in% c("Phylloicus bromeliarum", "Dysticid")) %>%
    mutate(prop.eaten = eaten/number.trials) %>%
    arrange(predator.names,Prey.species) %>%
    select(-number.trials,-eaten) %>%
    spread(Prey.species,prop.eaten,fill = NA)
}

make_prop_eaten_pianka <- function(prop.eaten){
  paired_predator_pianka(pred_x_resource = prop.eaten,
                         pred_colname = "predator.names",
                         -predator.names)
}


