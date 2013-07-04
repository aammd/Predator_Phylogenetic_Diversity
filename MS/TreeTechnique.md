# Techique for phylogenetic trees

The central concept of this paper is the _phylogenetic diversity_ of predators.  We want to test whether several traits of different predator species (diet similarity, coexistence, effect on the ecosystem, etc) are correlated with phylogenetic distance.

There are several ways we could measure 'distance' between species:

1.  taxonomic differences
2.  an "arbitrarily ultrametric" tree (similar to above)
3.  a tree with approximate branch lengths
4.  a home-made phylogeny with genetic data

Frankly, I'm not sure which is best.  **what do you think?**


```r
library(picante)
```



```r

insects_to_leeches <- mean(read.csv("../data/TreeData//insects.to.leeches.csv")$Time)
odonata_tabanid <- mean(read.csv("../data/TreeData/odonata-Tabanidae.csv")$Time)

predators_in_exp <- paste0("(((Leptagrion.andromache:", 15, ",Leptagrion.elongatum:", 
    15, "):", odonata_tabanid - 15, ",Tabanidae.spA:", odonata_tabanid, "):", 
    insects_to_leeches - odonata_tabanid, ",Hirudinidae:", insects_to_leeches, 
    ");")


pred_exp_phylo <- read.tree(text = predators_in_exp)
```


