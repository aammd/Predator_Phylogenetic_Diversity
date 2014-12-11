### what doesthis do and is it useful

## move to supp mat
phylogeny_node_age <- nodeages %>%
  select(nodename,age_data,Nstudies) %>% 
  do(extract2(.,"age_data") %>% 
       as.data.frame(stringsAsFactors = FALSE)
  ) %>%
  lapply(.,function(x) gsub(pattern = "\\(.+\\)",replacement = "",x)) %>% 
  data.frame