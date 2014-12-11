# nonlinear fit to diet data and corresponding confidence intervals.

library("dplyr")

diet_overlap_phylo <- read.csv("../data/diet_overlap_phylo.csv",
                               stringsAsFactors=FALSE) %>%   tbl_df()


x_sequence <- diet_overlap_phylo  %>%
  ungroup %>%
  summarise(min_x = min(phylodistance),
            max_x = max(phylodistance)) %>%
  do(seq(from = .$min_x,
         to = .$max_x,
         length.out = 500) %>%
       data.frame(phylodistance = .)
  ) 

rawdata <- diet_overlap_phylo %>% 
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
      predict(model, 
              data.frame(x = x_sequence))
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

diet_predictions <- x_sequence %>% tbl_df %>%
  mutate(pred_m2 = predict(observed_fit,
                           newdata = list(phylodistance = phylodistance)),
         upper = apply(predictions,1,quantile,prob = .975, na.rm = TRUE),
         lower = apply(predictions,1,quantile,prob = .025, na.rm = TRUE),
         category = "(b)",
         category = factor(category,levels = c("(b)", "Distribution"))
  )

write.csv(diet_predictions, file = "../data/diet_predictions.csv", row.names = FALSE)