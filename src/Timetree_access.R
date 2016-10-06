library(rvest)

## goal is a means of creating citations for the data from the website. These will appear in the supplementary material.


#' get the timetree table for a given family comparison
#'
#' @param fam1 
#' @param fam2 
#'
#' @return 
getpage <- function(fam1, fam2){
  
  "http://timetree.org/search/pairwise/" %>% 
    paste0(fam1, "/", fam2) %>% 
    read_html
}

culicidae_tabanidae <- getpage("culicidae", "tabanidae") 


get_links <- function(page){
  page %>% 
    html_nodes(".sortable a") %>% 
    sapply(html_attr, "href") %>% 
    unique %>% 
    Filter(function(x) str_detect(x, "[0-9]{5,}"), .)
}

get_pmids <- function(lnk){
  lnk %>% 
    str_extract("[0-9]{5,}") %>% 
    Filter(Negate(is.na), .)
}

get_summ <- function(pmid){
  entrez_summary(db ="pubmed" ,id = as.numeric(pmid))
 
}

get_ids <- function(summ){
  extract_from_esummary(esummaries = summ, "articleids")
}

get_all_citations <- function(t1, t2){
  getpage(t1, t2) %>% 
    get_links
}



citep()
write.bibtex(file="phylorefs.bib")

threefam <- data_frame(taxa1 = c("culicidae", "dolichopodidae", "chironomidae"),
           taxa2 = taxa1) %>% 
  expand(taxa1, taxa2) %>% 
  filter(taxa1 != taxa2) %>% 
  group_by(taxa1, taxa2) %>% 
  do(ans = get_all_citations(.$taxa1, .$taxa2))

w_dois <- threefam %>% 
  unnest(ans) %>% 
  mutate(pmid = get_pmids(ans)) %>% 
  group_by(pmid) %>% 
  do(entrezsum = get_summ(.$pmid))

w_dois[["entrezsum"]][[2]] %>% extract_from_esummary("articleids", simplify = FALSE)

w_dois %>% 
  do(ids = get_ids(.$entrezsum)) %>% 
  .[[1]] %>% 
  .[[1]] %>% 
  .[[1]]

## These links are dead, which is why there is no answer.

"http://timetree.org/search/pairwise/culicidae/chironomidae" %>% 
  read_html %>% 
  html_nodes(".sortable a") %>% 
  sapply(html_attr, "href") %>% 
  unique

"http://timetree.org/search/pairwise/culicidae/chironomidae" %>% 
  read_html %>% 
  html_nodes(".sortable") %>% 
  html_table()


