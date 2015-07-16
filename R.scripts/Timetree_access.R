library(rvest)

## goal is a means of creating citations for the data from the website. These will appear in the supplementary material.


#' get the timetree table for a given family comparison
#'
#' @param fam1 
#' @param fam2 
#'
#' @return 
getpage <- function(fam1, fam2){
page <- html("http://timetree.org/search/pairwise/tabanidae/culicidae")

times <- html_table(page)
}

times[[2]]

 urls <- page %>% 
  html_nodes(".sortable a") %>% 
  sapply(html_attr, "href")

knitcitations::citep("http://rspb.royalsocietypublishing.org/content/279/1732/1259.long")
