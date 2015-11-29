## to relate the predator phylogenetic distance to the diet or dist similarity we need to do a mantel test

##  diet measurements: ## ok the diet measurements are just a
#bit more involved, because they are not in the format of a matrix and they
#never were a matrix

## OK so first step is to turn it into a matrix
## spreading data.frame

make_mantel_test <- function(distance_df, .predtree_timetree_ages){
  meta_spread <- distance_df %>% 
    separate(species_pair, into = c("sp1", "sp2"), sep = "_") %>% 
    select(-nspp) %>% 
    spread(sp2, overlap)
  
  ## ugh, converting to matrix strips rownames! why is that sensible?
  meta_mat <- as.matrix(meta_spread[-1])
  
  row.names(meta_mat) <- meta_spread[["sp1"]]
  
  
  # rank the rows in descending order of non-NA values
  sortrows <- order(rowSums(!is.na(meta_mat)), decreasing = FALSE)
  ## rank columns the same way
  sortcols <- order(colSums(!is.na(meta_mat)), decreasing = TRUE)
  
  ## ok this matrix looks good
  sortedmat <- meta_mat[sortrows,sortcols]
  ## this matches the printed values.
  ## the only problem is that when we convert to a distance matrix it doesn't work the way we want it to.
  ## it chops off the diagonal, which in this case is needed.
  
  ## let me try making a better-behaved matrix. 
  ## start with an NA matrix, with the correct rownames
  ## ie same rownames as this, but add the first colname to the rows and the last rowname to the end of the cols:
  
  newmat <- matrix(NA, nrow = nrow(sortedmat) + 1, ncol = ncol(sortedmat) + 1)
  dimnames(newmat) <- list(
    c(
      colnames(sortedmat)[1],
      rownames(sortedmat)),
    c(
      colnames(sortedmat),
      rownames(sortedmat)[13]
    )
  )
  
  ## then just slap in our values:
  newmat[lower.tri(newmat)] <- sortedmat[lower.tri(sortedmat, diag = TRUE)]
  
  newmat_dist <- as.dist(newmat)
  
  
  ## first step: get the phylogenetic data in the right format:
  
  
  pdcophen <- cophenetic(.predtree_timetree_ages)
  
  # intersect(colnames(pdcophen), colnames(newmat))
  
  ## take only those columns and rows from the cophenetic matrix that match the
  ## sorted matrix, and take them in the same order
  pd_dist <- as.dist(pdcophen[rownames(newmat), colnames(newmat)])
  
  mantel(pd_dist, newmat_dist)
}


