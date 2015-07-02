# nonlinear fit to diet data and corresponding confidence intervals.

make_diet_predictions <- function(.diet_overlap_phylo){
  x_sequence <- .diet_overlap_phylo  %>%
    ungroup %>%
    summarise(min_x = min(phylodistance),
              max_x = max(phylodistance)) %>%
    do(seq(from = .$min_x,
           to = .$max_x,
           length.out = 500) %>%
         data.frame(phylodistance = .)
    ) 
  
  rawdata <- .diet_overlap_phylo %>% 
    ungroup %>% 
    select(phylodistance,overlap,nspp)
  
  predictions  <-  replicate(
    500,{
      boot  <- rawdata[sample.int(nrow(rawdata), replace = TRUE), ]
      #browser()
      model = nls(overlap ~ b * exp(a * phylodistance), 
                  data = boot, 
                  start = list(a = -0.0004, b = 1),
                  weights = nspp)
      # Output predictions at each point that we'll want to plot later
      if(!is.null(model)) {
        predict(model, x_sequence)
      }
      else {
        rep(NA,length(x_sequence))
      }
    },
    simplify = FALSE
  )
  
  predictions  <- do.call(cbind, predictions)
  
  observed_fit <- nls(overlap ~ b * exp(a * phylodistance), 
                      data = rawdata, 
                      start = list(a = -0.0004, b = 1),
                      weights = nspp)
  
  data_frame(
    phylodistance = x_sequence$phylodistance,
    pred_m2 = predict(observed_fit, x_sequence),
    upper = apply(predictions,1,quantile,prob = .975, na.rm = TRUE),
    lower = apply(predictions,1,quantile,prob = .025, na.rm = TRUE),
    category = "(b)"
  )

}
