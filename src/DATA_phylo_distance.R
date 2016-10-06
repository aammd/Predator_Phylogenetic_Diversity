####### metabolic matrix ####
## we need to calculate two distance matrices:
## 1) metabolic capacity distance
## 2) phylogenetic distance

calc_phylogenetic_dist <- function(.predtree_timetree_ages){
  .predtree_timetree_ages %>%
    cophenetic() %>%
    matrix_to_df() %>%
    select(phylopred1 = Var1,
           phylopred2 = Var2,
           phylodistance = value) %>%
    mutate(pairs_RH = paste0(phylopred1,"_",phylopred2),
           pairs_LH = paste0(phylopred2,"_",phylopred1)
    ) %>%
    melt(id.vars = c("phylopred1","phylopred2","phylodistance"),
         value.name = "species_pair",
         variable.name = "L_or_R")
}
