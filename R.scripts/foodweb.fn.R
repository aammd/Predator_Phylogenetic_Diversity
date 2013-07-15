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

