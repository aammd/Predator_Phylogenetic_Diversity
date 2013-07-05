# What's the best way to show phylogenetic relationships among predators?

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

## 'taxonomic' trees

This approach is simple: build a phylogeny which groups the predators by taxonomy.  The resulting distance matrix would just organize species as "far" or "not very far" from each other.


```r
predators_in_exp_ultrametric <- "(((Leptagrion.andromache,Leptagrion.elongatum),Tabanidae.spA),Hirudinidae);"
pred_exp_ultrametric.tree <- read.tree(text = predators_in_exp_ultrametric)
plot(pred_exp_ultrametric.tree)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


## trees with 'real' branch lengths

There are estimates of divergence times available at [TimeTree](http://www.timetree.org/).  I downloaded some data from there as .csv files, took the average, and assinged them to branches in the tree.  Thanks so much to all the [friendly commenters](https://www.zoology.ubc.ca/~macdonald/curious_interactions/taxonomy-tree/) who suggested this resource.  Here's the result:


```r

insects_to_leeches <- mean(read.csv("../data/TreeData//insects.to.leeches.csv")$Time)
odonata_tabanid <- mean(read.csv("../data/TreeData/odonata-Tabanidae.csv")$Time)

predators_in_exp <- paste0("(((Leptagrion.andromache:", 15, ",Leptagrion.elongatum:", 
    15, "):", odonata_tabanid - 15, ",Tabanidae.spA:", odonata_tabanid, "):", 
    insects_to_leeches - odonata_tabanid, ",Hirudinidae:", insects_to_leeches, 
    ");")


pred_exp_phylo <- read.tree(text = predators_in_exp)
plot(pred_exp_phylo)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


The only taxa for which TimeTree *doesn't* help are my two species of congeneric damselflies (*Leptagrion* sp.).  Yet, if the other edges have a length, these should too, right?  So, I set it at 15 Mya, the estimated age of the genus [*Enallagma*](http://www.enallagma.com/phylogeny.php).  I figured that choosing a "deeper" split like he origin of a whole genus makes the phylogeny more conservative, because it places the common ancestor of *Leptagrion* closer to the other. 

What do you think?  Utter fantasy or useful hack?

