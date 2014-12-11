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