## These are small functions which are used in inline code bits to extract
## summary info, and display in the text, in a knitr document. specialized for
## particular objects, hence the default arguements

## aammd Dec 2014


# function to print out range

agerange <- function(Name,pna = nodeages){
  minT <- pna %>%
    filter(nodename == Name) %>%
    extract2("minT")
  
  maxT <- pna %>%
    filter(nodename == Name) %>%
    extract2("maxT")
  
  paste0(minT," to ",maxT)
}

# how many studies does a given node have?
nstudy <- function(Name, dat = nodeages){
  dat %>%
    filter(nodename == Name) %>%
    extract2("Nstudies")
}

## Format the output of summary.lm for inline knitr
F_text <- function(model_summary){
  pval <- signif(pf(model_summary$fstatistic[1],
                   model_summary$fstatistic[2],
                   model_summary$fstatistic[3],lower.tail=FALSE)
                ,digits=2)
  
  fval <- round(model_summary$fstatistic[["value"]], digits = 2)
  
  paste0("F~", model_summary$fstatistic[["numdf"]], ",", model_summary$fstatistic[["dendf"]],
         "~=", fval, ", p=", pval)
}

## Extract pretty Fvals from the `modlist` object, which is a list of models.
prF <- function(resp,test,.modlist){
  modsum <- .modlist[[test]] %>%
    filter(response == resp) %>%
    extract2("m") %>%
    extract2(1) %>%
    summary 
  
  fv <- modsum %>%
    extract2("fstatistic")
  F_format <- paste0("F~",fv[["numdf"]],",",fv[["dendf"]],"~", " = ")
  pv <- pf(fv[1],fv[2],fv[3],lower.tail=F)
  
  fval <- signif(fv[["value"]], 2)
  
  if (pv < 0.05 & pv > 0.01) {
    paste0(F_format,fval,"\\*")
  } else if (pv < 0.01) {
    paste0(F_format,fval,"\\*\\*")
  } else {
    paste0(F_format,fval)      
  }
}

## polyculture effect sizes
polyeffect <- function(resp="total.surv"){
  diffeffect <- (mean(pd[[resp]][pd$treatment%in%c("elong + andro","elong + leech","elong + tab")],na.rm=TRUE)-mean(pd[[resp]][pd$treatment%in%c("andro","tabanid","leech","elong")],na.rm=TRUE))/mean(pd[[resp]][pd$treatment=="control"],na.rm=TRUE)
  round(diffeffect,digits=2)*100
}

## predator effect sizes
predeffect <- function(resp="total.surv"){
  diffeffect <- (mean(pd[[resp]][pd$treatment!="control"],na.rm=TRUE)-mean(pd[[resp]][pd$treatment=="control"],na.rm=TRUE))/mean(pd[[resp]][pd$treatment=="control"],na.rm=TRUE)
  round(diffeffect,digits=2)*100
}

