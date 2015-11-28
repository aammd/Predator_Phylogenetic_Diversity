remake::dump_environment()
diet_overlap_phylo

View(diet_overlap_phylo)

?mantel

## need to make the phylopred2 into a column

diet_overlap_phylo %>% ungroup %>% 
  select(phylopred1, phylopred2, phylodistance) %>% 
  spread(phylopred2, phylodistance)

## distance matrix
predtree_cophen <- predtree_timetree_ages %>% cophenetic()
class(predtree_cophen)

spred_diet <- diet_overlap %>% 
  separate(species_pair, c("sp1", "sp2"), sep = "_") %>% 
  select(-nspp) %>% 
  spread(sp2, overlap)

rownames(spred_diet) <- spred_diet[["sp1"]]

spred_diet %>% 
  select(-sp1) %>% 
  as.matrix %>% 
#   cbind(matrix(NA, 7 , 1, dimnames = list(NULL, "Hirudinidae")),
#         .) %>% 
  t %>% 
  as.dist
firef