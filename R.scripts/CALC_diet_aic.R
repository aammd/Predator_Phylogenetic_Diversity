
library("dplyr")
## load in functions
source("../R.scripts/FUNCTIONS_predator_diversity.R")

diet_overlap_phylo <- read.csv("../data/diet_overlap_phylo.csv",
                               stringsAsFactors=FALSE) %>%   tbl_df()

### Diet

f_extract <- function(f,.models) sapply(.models,function(x) f(x[[1]]))

diet_models <- diet_overlap_phylo %>% 
  ungroup %>% 
  select(phylodistance,overlap,nspp) %>%
  do(quadratic = nls(overlap ~ a * (phylodistance)^2 + b * phylodistance + c, 
                     data = ., 
                     start = list(a = -0.0000008, b = 0.0008, c = 1),
                     weights = nspp),
     bellshaped = nls(overlap ~ peak * exp(-1 * (phylodistance)^2 / a), 
                      data = ., 
                      start = list(a = 900000, peak = 1),
                      weights = nspp),    
     exponential = nls(overlap ~ b * exp(a * phylodistance),
                       data = .,
                       start = list(a = -0.0004, b = 1),
                       weights = nspp),
     #        Sshaped = nls(overlap ~ c * exp(a * phylodistance) / 
     #                        (c * exp(a * phylodistance) + (1 - c)),
     #                      data = .,
     #                      start = list(a = -0.007, c = 0.9)),
     linear = nls(overlap ~ a* phylodistance + b, 
                  data = .,
                  start = list(a = -0.1,b = 0.7), weights = nspp),
     constant = nls(overlap ~ z,
                    data = .,
                    start = list(z = 0.4),
                    weights = nspp)
  ) 


data.frame(model = names(diet_models),
           AIC = f_extract(AIC,diet_models)) %>%
  arrange(AIC) %>%
  write.csv(file = "../data/diet_similarity_AIC.csv")
