
make_metabolic_dist_pianka <- function(.metabolic){
  paired_predator_pianka(pred_x_resource = .metabolic,
                         pred_colname = "Taxa",
                         ... =-Taxa)
}


