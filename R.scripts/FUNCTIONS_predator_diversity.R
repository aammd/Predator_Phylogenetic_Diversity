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
       linear = lm(overlap ~ phylodistance, data = .),
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
    geom_point(shape  = 21, size = 4) + 
    geom_point(colour = "black", fill = "darkgrey", size = 4, shape  = 21, alpha = 0.6) + 
    #   geom_point(aes(x = PD_mean,
    #                  y = grp_mean,
    #                  size = grp_n),
    #              colour = "black", shape = 21) + 
    #   geom_linerange(aes(x = PD_mean,
    #                       ymin = grp_mean - grp_se,
    #                       ymax = grp_mean + grp_se),
    #                   colour = "black") + 
    #   scale_size(range = c(3,9),name="Number of\npoints per\nmean") + 
    xlab("Phylogenetic distance") + ylab("Overlap in habitat use") + 
    mytheme
  
  model_formula <- as.formula(formula_quote)
  
  x_sequence <- metabolic_occur_phylo  %>%
    ungroup %>%
    summarize(min_x = min(phylodistance),
              max_x = max(phylodistance)) %>%
    do(seq(from = .$min_x,
           to = .$max_x,
           length.out = 500) %>%
         data.frame(phylodistance = .)
    ) 
  
  rawdata <- metabolic_occur_phylo %>% 
    ungroup %>% 
    select(phylodistance,overlap)
  
  predictions  <-  replicate(
    100,{
      boot  <- rawdata[sample.int(nrow(rawdata), replace = TRUE), ]
      model = failwith(NULL,nls)(model_formula, 
                                 data = boot, 
                                 start = list(a = 900000, peak = 1))
      # Output predictions at each point that we'll want to plot later
      if(!is.null(model)) predict(model, data.frame(x = x_sequence)) else rep(NA,length(x_sequence))
    }
  )
  
  #  browser()
  
  observed_fit <- nls(overlap ~ peak * exp(-1 * (phylodistance)^2 / a), 
                      data = rawdata, 
                      start = list(a = 900000, peak = 1))
  
  x_sequence %>%
    mutate(pred_m2 = predict(observed_fit,newdata = list(phylodistance = phylodistance)),
           upper = apply(predictions, 1, quantile, .975, na.rm = TRUE),
           lower = apply(predictions, 1, quantile, .025, na.rm = TRUE)
    ) %>% 
    #  gather(model,prediction,-phylodistance) %>%
    (function(x) fig1 + geom_line(aes(x = phylodistance, y = pred_m2),data = x) +
       geom_line(aes(x = phylodistance, y = upper),data = x,linetype = "dashed") +
       geom_line(aes(x = phylodistance, y = lower),data = x,linetype = "dashed")
    ) 
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
    melt(as.is=TRUE) %>%                    # as.is important for preventing factors
    filter(matrix_for_df %>% 
             upper.tri %>% 
             melt %>% 
             extract2("value")
    )
}

## To make comparisions between pairs of predators, we need a factor
## which indicates which two predators are being compared.
## to do that, I want to pair all the predator names together, say in a square matrix, and then melt it to obtain the paired rows:

paired_predator_pianka <- function(pred_x_resource,pred_colname,...){
  
  taxa_names <- pred_x_resource %>% extract2(pred_colname)
  
  prednames <- taxa_names %>%
    unique %>%
    (function(x) set_names(x,x)) %>%
    (function(x) outer(x,x,paste,sep="_")) %>%
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
    do(. %>% select(-species_pair) %>% pianka)
}
## then we calculate similarity for each.  for the predation data, we must first remove animals not assayed with both predators. the `pianka` function does this by removing those with NA colSums.

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



diffs <- function(vec,resp)
{
  ##calculates mean of two values and subtracts a third
  ##vec = vector of rows (subscripts), representing randomly chosen
  ##bromeliads
  ##resp = response variable, character
  mean(pd[vec[1:2],resp],na.rm=T)-pd[vec[3],resp]
}


randomz.diff <- function(sp.1,sp.2,combo,resp,runs=10)
{
  ##this function applies diffs to two monocultures and one polyculture.
  ## sp.1 = one monoculture
  ## sp.2 = the other monoculture
  ## combo = the combined treatments
  ## resp = the desired response variable
  ## runs = the number of simulations
  sp.A <- which(pd$treatment==sp.1)
  sp.B <- which(pd$treatment==sp.2)
  poly <- which(pd$treatment==combo)
  
  ##make a matrix of randomized subscripts
  subscript.matrix <- cbind(sample(sp.A,runs,replace=T),
                            sample(sp.B,runs,replace=T),
                            sample(poly,runs,replace=T))
  
  ## then apply diffs to each row
  apply(subscript.matrix,1,diffs,resp=resp)
  
}


##want a function that will work on subscript.matrix
## that will calculate the mean for all 5 values first and then do subtraction.


randomize.resp  <- function(resp.var,runs)
  ## this function is a wrapper for randomz.diff
  ## it provides the non-additive effect for each predator combination
  ## leaves the choice of resp.var and runs
  
  ## resp.var = response variable
  ## runs = n simulations
{
  el <-data.frame(diffs=randomz.diff("leech","elong",
                                     "elong + leech",resp=resp.var,runs=runs),
                  trt='elong + leech')
  et <-data.frame(diffs=randomz.diff("tabanid","elong",
                                     "elong + tab",resp=resp.var,runs=runs),
                  trt='elong + tab')
  
  ea <- data.frame(diffs=randomz.diff("andro","elong",
                                      "elong + andro",resp=resp.var,runs=runs),
                   trt='elong + andro')
  outs <- rbind(el,et,ea)
  outs
}



responses <- function(runs)
  ## this function wraps around randomize.resp, and applies it over
  ## all the responses
  ## also gets rid of the names column in all but one.
{
  survival=randomize.resp(resp.var="total.surv",runs=runs)
  fine=randomize.resp(resp.var="fine",runs=runs)
  decomp=randomize.resp(resp.var="decomp",runs=runs)
  growth=randomize.resp(resp.var="growth",runs=runs)
  data.frame(survival=survival[,1],
             fine=fine[,1],
             decomp=decomp[,1],
             growth=growth[,1],
             sp.pair=growth$trt)
}


# analyze the means -------------------------------------------------------

## at this point, Diane and I decided to change the analysis.  We
## chose instead to take the average of each group after randomizing,
## and _then_ to take the subtraction.  This seems logical since we
## would do it like this with raw data, anyway.


randomz.diff.means <- function(sp.1,sp.2,combo,resp,runs=10)
{
  ##this function applies diffs to two monocultures and one polyculture.
  ## sp.1 = one monoculture
  ## sp.2 = the other monoculture
  ## combo = the combined treatments
  ## resp = the desired response variable
  ## runs = the number of simulations
  sp.A <- which(pd$treatment==sp.1)
  sp.B <- which(pd$treatment==sp.2)
  poly <- which(pd$treatment==combo)
  
  outs <- numeric(length=runs)
  for (i in 1:runs)
  {
    ##make a matrix of randomized subscripts
    subs.mat <- cbind(sample(sp.A,5,replace=T),
                      sample(sp.B,5,replace=T),
                      sample(poly,5,replace=T))
    ## take the mean of each group,
    ## then the mean of both groups (the additive combination)
    ## then substraction of the polyculture mean
    outs[i] <- mean(
      mean(pd[subs.mat[,1],resp],na.rm=T),
      mean(pd[subs.mat[,2],resp],na.rm=T)
    )-mean(pd[subs.mat[,3],resp],na.rm=T)
  }
  outs
}


randomize.resp.means  <- function(resp.var,runs)
{
  el <-data.frame(diffs=randomz.diff.means("leech","elong",
                                           "elong + leech",resp=resp.var,runs=runs),
                  trt='elong + leech')
  et <-data.frame(diffs=randomz.diff.means("tabanid","elong",
                                           "elong + tab",resp=resp.var,runs=runs),
                  trt='elong + tab')
  
  ea <- data.frame(diffs=randomz.diff.means("andro","elong",
                                            "elong + andro",resp=resp.var,runs=runs),
                   trt='elong + andro')
  outs <- rbind(el,et,ea)
  outs
}




responses.means <- function(runs)
{
  survival=randomize.resp.means(resp.var="total.surv",runs=runs)
  fine=randomize.resp.means(resp.var="fine",runs=runs)
  decomp=randomize.resp.means(resp.var="decomp",runs=runs)
  growth=randomize.resp.means(resp.var="growth",runs=runs)
  N=randomize.resp.means(resp.var="X15N",runs=runs)
  out <- data.frame(survival=survival[,1],
                    fine=fine[,1],
                    decomp=decomp[,1],
                    growth=growth[,1],
                    N=N[,1],
                    sp.pair=growth$trt)
  out
}




# graphing functions ------------------------------------------------------


ci.resp <- function(n,sim.data=rand.means,
                    Ylab="monoculture mean - polyculture mean (n=5)")
{
  ## the randomizations need to have confidence intervals on them.  it
  ## is made especially to run on the output of responses.means IF YOU
  ## CHANGE responses.means THIS FUNCTION WILL NOT WORK and will need
  ## to be fixed!
  
  ## n = is the column of sim.data that has the variable of interest
  ## sim.data = the output of responses.means.  it is set to what I
  ## called this output in the master file.
  ## Ylab = label for yaxis
  
  means <- aggregate(sim.data[,2:6],
                     by=list(sp.pair=sim.data$sp.pair),mean,na.rm=T)
  low <- aggregate(sim.data[,2:6],
                   by=list(sp.pair=sim.data$sp.pair),quantile,
                   probs=0.025,na.rm=T)
  high <- aggregate(sim.data[,2:6],
                    by=list(sp.pair=sim.data$sp.pair),quantile,
                    probs=0.975,na.rm=T)
  #  browser()
  plotCI(means[,n],ui=high[,n],li=low[,n],
         ylab=Ylab,
         main=NULL,xaxt="n",xlab="treatment")
  axis(side=1,labels=means[,1],at=1:3)
  abline(h=0,lty=2)
}


three.pt <- function(x){
  ## this function is meant to work on a very specific dataframe
  ## it creates a graph of points, showing the elongatum mean, the
  ## mean of one of the three combination predators, and their
  ## additive treatment.
  attach(x)
  plot(total.surv.mean,decomp.mean,type='n',
       ylim=c(0.2,0.5),xlim=c(0,25),ylab="",xlab="",
       yaxt=yaxis[1])
  
  segments(x0=total.surv.mean-total.surv.ci,
           y0=decomp.mean,
           x1=total.surv.mean+total.surv.ci,
           y1=decomp.mean
  )
  segments(x0=total.surv.mean,
           y0=decomp.mean-decomp.ci,
           x1=total.surv.mean,
           y1=decomp.mean+decomp.ci
  )
  points(total.surv.mean,decomp.mean,
         pch=pchs,
         bg=colours,
         cex=2)
  detach(x)
}


pred.graph <- function(resp.x="total.surv",resp.y="decomp"){
  ## predator graph -- as seen in Thesis Proposal!  this is a useful
  ## plot, showing how the non-additive effects of the predators
  ## effect emergence and decomposition simultandously collect the
  ## numbers
  
  pd.means <-
    aggregate(pd[,c(resp.x,resp.y)],by=pd["treatment"],FUN=mean,na.rm=TRUE)
  
  pd.ci <- aggregate(pd[,c(resp.x,resp.y)],
                     by=pd["treatment"],FUN=function(x)
                       sd(x,na.rm=TRUE)/sqrt(sum(!is.na(x)))) #removes
  #na values, counts all the
  #non-NA numbers for sample
  #size.
  ## means and ci for each treatment - all in one dataframe
  
  pd.plot <- merge(pd.means,pd.ci,by.x="treatment",by.y="treatment",
                   suffixes=c(".mean",".ci"))
  
  ## assign colours to dots
  
  pd.plot$colours <-
    c("grey","grey39","white","black","black","black","grey","grey")
  pd.plot$pchs <- c(21,22,21,21,21,21,23,24)
  
  trts <- list(c("control","elong","andro","elong + andro"),
               c("control","elong","tabanid","elong + tab"),
               c("control","elong","leech","elong + leech") )
  
  ##creates a list, each entry is a dataframe with the data for a
  ##separate part of the plant.
  
  pd.plot.groups <- lapply(trts,function(x)
    pd.plot[match(x,pd.plot$treatment),])
  
  ## controlling the presence of the y-axis? rather crude, but hey.
  pd.plot.groups[[1]]$yaxis <- rep("s",4)
  pd.plot.groups[[2]]$yaxis <- rep("n",4)
  pd.plot.groups[[3]]$yaxis <- rep("n",4)
  
  par(mfrow=c(1,3),oma=c(2,5,0,2),mar=c(5.1,0,4.1,0.5),bty="l")
  #,pin=c(6,4))
  lapply(pd.plot.groups,three.pt)
  mtext("mean detritivore survivorship",1,line=-1,outer=TRUE)
  mtext("mean decomposition (%)",side=2,line=3,outer=TRUE)
}


effect.2d <-  function(combo,sim.data=rand.means,xvar,yvar){
  ## the randomizations need to have confidence intervals on them.  it
  ## is made especially to run on the output of responses.means IF YOU
  ## CHANGE responses.means THIS FUNCTION WILL NOT WORK and will need
  ## to be fixed!
  
  ## n = is the column of sim.data that has the variable of interest
  ## sim.data = the output of responses.means.  it is set to what I
  ## called this output in the master file.
  ## Ylab = label for yaxis
  
  means <- aggregate(sim.data[,2:6],
                     by=list(sp.pair=sim.data$sp.pair),mean,na.rm=T)
  low <- aggregate(sim.data[,2:6],
                   by=list(sp.pair=sim.data$sp.pair),quantile,
                   probs=0.025,na.rm=T)
  high <- aggregate(sim.data[,2:6],
                    by=list(sp.pair=sim.data$sp.pair),quantile,
                    probs=0.975,na.rm=T)
  
  trt <- which(means[,1]==combo)
  
  xm <- means[trt,xvar]
  xl <- low[trt,xvar]
  xu <- high[trt,xvar]
  
  ym <- means[trt,yvar]
  yl <- low[trt,yvar]
  yu <- high[trt,yvar]
  
  ##browser()
  plot(x=xm,y=ym,type='n',ylim=c(-15,5),xlim=c(-0.2,0.2),ylab="",xlab="")
  
  abline(h=0,lty=2,col="gray")
  abline(v=0,lty=2,col="gray")
  
  segments(x0=xl,
           y0=ym,
           x1=xu,
           y1=ym
  )
  segments(x0=xm,
           y0=yl,
           x1=xm,
           y1=yu
  )
  
  points(xm,
         ym,
         pch=21,
         bg="grey",
         cex=2)
}

bivar.graph <- function(xvar.lab="decomposition (%)",yvar.lab="detritivore survivorship",Yvar,Xvar){
  par(mfrow=c(1,3),oma=c(2,5,0,2),mar=c(5.1,0,4.1,0.5),bty="l")
  #  par(cex=3)
  effect.2d("elong + andro",xvar=Xvar,yvar=Yvar)
  par(yaxt='n')
  grps <- c("elong + tab","elong + leech")
  lapply(grps,effect.2d,xvar=Xvar,yvar=Yvar)
  mtext(text=xvar.lab,side=1,line=-1,outer=TRUE)#,cex=3)
  mtext(text=yvar.lab,side=2,line=3,outer=TRUE)#,cex=3)
  
}

## functions for graphing and analyzing the predator-diversity and ecosystem function experiment

## phylogenetic data can be subsetted to give just those in the experiment
prune_predators <- function(names_predators=c("Leptagrion.andromache","Leptagrion.elongatum",
                                              "Tabanidae.spA","Hirudinidae"),
                            .predtree_timetree_ages=predtree_timetree_ages){
  mat <- matrix(1,nrow=4)
  rownames(mat) <- names_predators
  prune.sample(phylo=.predtree_timetree_ages,samp=t(mat))
}


## graphs the foodweb
picture <- function(preds,spread=2)
{
  prey.list <- levels(preds$Prey)
  pred.list <- levels(preds$Predator)
  
  pred.list.range <- 1:length(pred.list)+(length(prey.list)-length(pred.list))/2
  
  pred.list.range <- (pred.list.range - median(pred.list.range)) * spread + median(pred.list.range)
  
  
  with(preds,plot(x=c(rep(1,length(prey.list)),rep(2,length(pred.list))),
                  y=c(1:length(prey.list),pred.list.range),
                  type="n",
                  xlim=c(-2,5),
                  xlab="",
                  ylab="",
                  axes=FALSE
  )
  )
  
  with(preds,text(x=rep(1,length(prey.list)),
                  y=1:length(prey.list),
                  labels=prey.list,
                  pos=2
  )
  )
  
  with(preds,text(x=rep(3,length(pred.list)),
                  y=pred.list.range,
                  labels=pred.list,
                  pos=4
  )
  )
  
  #all the combinations
  for(i in 1:dim(preds)[1]){
    
    with(preds,arrows(x0=1,
                      y0=which(prey.list==preds[i,"Prey"]),
                      x1=3,
                      y1=pred.list.range[which(pred.list==preds[i,"Predator"])],
                      col='grey',
                      lwd=1,
                      length=0.1,
                      lty=2
    )
    )
  }
  
  # all the combinations where there was eating!
  for(i in 1:dim(preds)[1]){
    
    with(preds,arrows(x0=1,
                      y0=which(prey.list==preds[i,"Prey"]),
                      x1=3,
                      y1=pred.list.range[which(pred.list==preds[i,"Predator"])],
                      col='black',
                      lwd=5*(preds[i,"eaten"]),
                      length=0.1
    )
    )
  }
  
}

