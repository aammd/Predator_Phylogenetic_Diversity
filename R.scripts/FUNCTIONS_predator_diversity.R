### functions for analyzing predator diversity experiment 2011
## June 2011, Andrew MacDonald


fit_some_models <- function(data_phylo_overlap){

  
  models_to_fit <- data.frame(formulae = c(
    "quadratic" = "overlap ~ a * (phylodistance)^2 + b * phylodistance + c",
    "bellshaped" = "overlap ~ peak * exp(-1 * (phylodistance)^2 / a)",
    "exponential" = "overlap ~ b * exp(a * phylodistance)",
    "Sshaped" = "overlap ~ c * exp(a * phylodistance) / (c * exp(a * phylodistance) + (1 - c))")
  ) %>% tbl_df()
  
  models_to_fit$start <-  list(
    list(a = -0.0000008, b = 0.0008, c = 1),
    list(a = 900000, peak = 1),
    list(a = -0.0004, b = 1),
    list(a = -0.007, c = 0.9))
  
  # class(models_to_fit) <- c("tbl_df", "data.frame")
  # attr(models_to_fit, "row.names") <- .set_row_names(length(models_to_fit))
  
  models <- data_phylo_overlap %>%
    do(quadratic = nls(overlap ~ a * (phylodistance)^2 + b * phylodistance + c, 
                       data = ., 
                       start = list(a = -0.0000008, b = 0.0008, c = 1)),
       bellshaped = nls(overlap ~ peak * exp(-1 * (phylodistance)^2 / a), 
                        data = ., 
                        start = list(a = 900000, peak = 1)),    
       exponential = nls(overlap ~ b * exp(a * phylodistance),
                         data = .,
                         start = list(a = -0.0004, b = 1)),
#        Sshaped = nls(overlap ~ c * exp(a * phylodistance) / 
#                        (c * exp(a * phylodistance) + (1 - c)),
#                      data = .,
#                      start = list(a = -0.007, c = 0.9)),
       linear = nls(overlap ~ a* phylodistance + b, 
                    data = .,
                    start = list(a = -0.1,b = 0.7)),
       constant = nls(overlap ~ z,
                      data = .,
                      start = list(z = 0.4))
    ) 
  
  f_extract <- function(f) sapply(models,function(x) f(x[[1]]))
  
  data.frame(model = names(models),
             AIC = f_extract(AIC)) %>%
    arrange(AIC)
}

pianka_plot <- function(data_phylo_overlap,formula_quote="overlap ~ peak * exp(-1 * (phylodistance)^2 / a)"){
  fig1 <- data_phylo_overlap %>%
    #   group_by(PDgrp) %>%
    #   mutate(grp_mean = mean(overlap),
    #          grp_n = n(),
    #          grp_se = sd(overlap)/sqrt(grp_n),
    #          PD_mean = mean(phylodistance)) %>%
    ggplot(aes(x = phylodistance, y = overlap)) + 
    geom_point(shape  = 21, size = 6) + 
    geom_point(colour = "black", fill = "#00A08A", size = 6, shape  = 21, alpha = 0.6) + 
    #   geom_point(aes(x = PD_mean,
    #                  y = grp_mean,
    #                  size = grp_n),
    #              colour = "black", shape = 21) + 
    #   geom_linerange(aes(x = PD_mean,
    #                       ymin = grp_mean - grp_se,
    #                       ymax = grp_mean + grp_se),
    #                   colour = "black") + 
    #   scale_size(range = c(3,9),name="Number of\npoints per\nmean") + 
    xlab("Phylogenetic distance") + ylab("Distributional similarity (Pianka's index)") + 
    mytheme
  
  model_formula <- as.formula(formula_quote)
  
  x_sequence <- metabolic_occur_phylo  %>%
    ungroup %>%
    summarise(min_x = min(phylodistance),
              max_x = max(phylodistance)) %>%
    do(seq(from = .$min_x,
           to = .$max_x,
           length.out = 500) %>%
         data.frame(phylodistance = .)
    ) 
  
  rawdata <- metabolic_occur_phylo %>% 
    ungroup %>% 
    select(phylodistance,overlap)
  
  predictions  <-  replicate(n = 100,
                             expr = {
                               boot  <- rawdata[sample.int(nrow(rawdata), replace = TRUE), ]
                               model = failwith(NULL,nls)(model_formula, 
                                                          data = boot, 
                                                          start = list(a = 900000, peak = 1))
                               # Output predictions at each point that we'll want to plot later
                               if(!is.null(model)) {
                                 predict(model, 
                                         data.frame(x = x_sequence))
                               }
                               else {
                                 rep(NA,length(x_sequence))
                               }
                             },
                             simplify = FALSE
  )
  #browser()
  
  predictions  <- do.call(cbind,predictions)
  # browser()
  
  observed_fit <- nls(overlap ~ peak * exp(-1 * (phylodistance)^2 / a), 
                      data = rawdata, 
                      start = list(a = 900000, peak = 1))
  
  x_sequence %>%
    mutate(pred_m2 = predict(observed_fit,newdata = list(phylodistance = phylodistance)),
           upper = apply(predictions,1,quantile,prob = .975, na.rm = TRUE),
           lower = apply(predictions,1,quantile,prob = .025, na.rm = TRUE)
    ) %>% 
    #  gather(model,prediction,-phylodistance) %>%
    function(x) {fig1 + geom_line(aes(x = phylodistance, y = pred_m2),data = x) +
                   geom_line(aes(x = phylodistance, y = upper),data = x,linetype = "dashed") +
                   geom_line(aes(x = phylodistance, y = lower),data = x,linetype = "dashed")
    } 
}



list_to_df <- function(listfordf){
  if(!is.list(listfordf)) stop("it should be a list")
  
  df <- list(list.element = listfordf)
  class(df) <- c("tbl_df", "data.frame")
  attr(df, "row.names") <- .set_row_names(length(listfordf))
  
  if (!is.null(names(listfordf))) {
    df$name <- names(listfordf)
  }
  
  df
}


# This function turns a matrix into a dataframe
matrix_to_df <- function(matrix_for_df){
  matrix_for_df %>% 
    melt(as.is=TRUE) %>%      # as.is important for preventing factors
    filter(matrix_for_df %>% 
             upper.tri %>% 
             melt %>% 
             extract2("value")
    )
}

## To make comparisions between pairs of predators, we need a factor which
## indicates which two predators are being compared. to do that, I want to pair
## all the predator names together, say in a square matrix, and then melt it to
## obtain the paired rows:

paired_predator_pianka <- function(pred_x_resource,pred_colname,...){
  #browser()
  taxa_names <- pred_x_resource %>% extract2(pred_colname)
  
  prednames <- taxa_names %>%
    unique %>% set_names(.,.) %>%
    outer(.,.,paste,sep="_") %>%
    matrix_to_df() %>%
    select(dietpred1=Var1,dietpred2=Var2,species_pair=value)
  
  taxa_names %>% unique %>% length %>% choose(2) %>%
    equals(prednames %>% nrow) %>%
    not %>%
    if(.) stop(message("The number of rows in output does not match the number of possible pairs"))
  
  ## next merge with the actual data
  prednames %>%
    melt(id.vars = "species_pair",value.name=pred_colname) %>%  ## giving same name here for merging later
    mutate(species_pair=as.character(species_pair)) %>% 
    left_join(pred_x_resource) %>% 
    select(-variable,...) %>%
    group_by(species_pair) %>%
    do(pianka(select_(., quote(-species_pair))))
}


## then we calculate similarity for each.  for the predation data, we must first
## remove animals not assayed with both predators. the `pianka` function does
## this by removing those with NA colSums.

## then we merge with phylogenetic data.


## both ecopath and ecosim documentation (and those sources derived from them)
## imply a different formula for Pianka's index.
pianka <- function(df){
  ## remove resources never tested on both animals
  mat <- df %>% 
    as.matrix %>%
    colSums %>% 
    is.na %>%
    not %>%
    df[.]
  
  # scale rows
  rowtotal <- rowSums(mat)
  mat <- apply(mat,2,function(x) x/rowtotal)
  
  squares <- mat^2
  sum_sq_prod <- prod(rowSums(squares))
  
  prod <- apply(mat,2,prod)
  sum_prod <- sum(prod)
  
  overlap <- sum_prod/sqrt(sum_sq_prod)
  nspp <- ncol(mat)
  data.frame(overlap,nspp)
}
