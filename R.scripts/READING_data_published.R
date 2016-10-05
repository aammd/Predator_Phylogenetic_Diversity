## loading in published data

read_published_data <- function(data_id){
  url <- fs_download(data_id)
  
  read_csv(url, comment = "#")
}


read_published_newick <- function(data_id){
  url <- fs_download(data_id)
  
  read.tree(url)
}