%Predator phylogenetic diversity decreases predation rate via antagonistic interactions
%A. Andrew M. MacDonald, Diane S. Srivastava, Gustavo Q. Romero





```r
# dropping a record that seems to have been 90% decomposed!
pd[which(pd$decomp > 0.7), "decomp"] <- NA
## just to make sure:
with(pd, table(treatment))
```

```
## treatment
##         andro       control         elong elong + andro elong + leech 
##             5             5             5             5             5 
##   elong + tab         leech       tabanid 
##             5             5             5
```

```r
head(pd)
```

```
##   eu  Id  wt            name    N   X15N d15N emerged   fine n15.leaves
## 1  1 EU1 5.8              B1 46.9 0.3653 -2.8       0 0.5783         31
## 2  2 EU2 6.2              B6 82.2 0.3713 13.6       0 0.6755         26
## 3  3 EU3 6.2              B7 46.8 0.3694  8.4       0 0.1966          6
## 4  4 EU4 6.2              D6 34.4 0.3714 13.9       1 1.3413          4
## 5  5 EU5 5.9 Romero_Tray1_A1 51.4 0.3700 10.1       4 0.8255         11
## 6  6 EU6 5.8              D7 59.6 0.3733 19.1       2 0.4996         40
##   leaf.mass bromeliad growth     treatment fine.detritus mass.g. decomp
## 1    0.9677         6   5.06         andro             1   1.514 0.3608
## 2    0.9127         9   5.58       tabanid            10   1.498 0.3908
## 3    1.0063        12   6.48       tabanid            18   1.506 0.3319
## 4    1.0193         3   3.50 elong + andro            33   1.504 0.3221
## 5    0.9035        10   3.34       control            20   1.502 0.3985
## 6    0.9469         8  -1.12 elong + andro             8   1.514 0.3748
##   Culicidae Chironomidae Tipulidae Psychodidae Scirtidae total.surv leech
## 1         0            1         1           0         0          2     0
## 2         0            0         0           0         5          5     0
## 3         1            1         0           0         3          5     0
## 4         0            2         1           1         3          7     0
## 5         3           13         1           1         2         20     0
## 6         0            0         1           0         0          1     0
##   andro tab elong
## 1     1   0     0
## 2     0   1     0
## 3     0   1     0
## 4     1   0     1
## 5     0   0     0
## 6     1   0     1
```


## Introduction


<!-- 
Predators are present in most ecosystems, and are important functional groups in determining ecosystem function.  While predator-prey relationships have been studied for a long time, we understand little of the effects of predator diversity on whole communites and ecosystems.  Phylogenetic diversity of plants may correlates well with community level variables, but as yet studies of predator combinations rarely use measures of predator phylogenetic diversity.  In our study we present results from patterns of predator co-occurance, feeding trials, finally a community-level experiment in which we directly manipulated phylogenetic diversity of predators.  In each we ask if the phylogenetic distance between predators is related to similarity, or if diversity is correlated with effect on ecosystem function
.
Decreasing predator richness has been shown to increase herbivory [@Byrnes2006] in a three-level kelp food web.  As these authors point out, the effect of diversity on ecosystem functioning is better known for lower tropic levels, rather than predators.   
Predator combinations can have many different outcomes.  From the perspective of ecosystem function it is important to consider whether these result in more or less top-down control.  Predator effects can be direct via changes in consumption, indirect via non-consumptive effects.  in other words, it can be via the effects of predators on each other, or on their prey, and directly or indirectly.  Therefore, in our experiment we tracked both predator and prey survival to the end of the experiment

for example, predators can kill each other, or decrease feeding rates. 
-->

We test three related hypotheses: 

1. *species co-occurance*: closely-related predators occur together more frequently than less-related predators, due to their similar habitat requirements.  Additionally, very closely related species never co-occur because they are  too similar.

2. *diet similarity*: similarity in diet (as measured by feeding trials) decreases with phylogenetic distance.

3. *ecosystem-level effects*: similarity in the effect of predators on whole ecosystems declines with phylogenetic distance.  Additionally, the non-additive effect of predators will have a greater absolute value when their phylogenetic diversity is larger.


## Methods

<!-- 
We combined predators together in species pairs that represented a
range of relatedness: congeners (two congeneric damselflies,
*Leptagrion andromache* and *Leptagrion elongatum*), two
insects (a damselfly, *L. elongatum* and a predatory fly
(Diptera: Tabanidae)) and two invertebrates (*L. elongatum* and
leeches).  We also included these four species in monoculture, along
with a predator-free control (8 treatments, n=5).  Combinations were
substitutive, maintaining the same amount of predator metabolic
capacity (biomass raised to the power of 0.69, predicting the scaling
of metabolism with body mass [@Brown2004]) in each.  Response
variables included the rate of decomposition of leaves, bromeliad
growth and insect emergence.  This experiment allows the estimation of
the effect of each predator species from monoculture treatments, as
well as the detection of non-additive effects in predator
combinations. 

In Feburary 2011, bromeliads between 90 and 200ml were collected,
thoroughly washed and soaked for 12 hours in a tub of water.  They
were then hung for 48 hours to dry.  One bromeliad dissected after
this procedure contained no insects.

Each bromeliad was supplied with dried leaves, simulating natural
detritus inputs from the canopy.  We enriched these leaves with N-15
by fertilizing five (Jabuticaba, *Plinia cauliflora*) plants with
40ml/pot/day of 5g/L ammonium sulphate containing 10 percent atom
excess of N15. *duration*. started on 27/1/2011
Whole leaves were then picked from plants and air-dried until constant
weight, and then soaked for three days and the water discarded.  About
1.5 g of leaves were placed in each bromeliad (1.5006 ± 0.0248). 

Each bromeliad was stocked with a representative insect community.
The densities of each prey taxon were calculated from a 2008
observational dataset, using data from bromeliads of similar size to
those in our experiment (DS Srivastava, upub. data).  All densities
used were within the range of these calculated abundances, and all
experimental bromeliads received the same insect community.  Halfway
through the experiment, insects were added to bromeliads a second
time.

\begin{table}
  \centering
  \caption{densities of each species}
  \label{tab:sppden}
  \begin{tabular}{l l}
    \hline
    \emph{Chironomus detriticula} & 10 \\
    \emph{Polypedium} sp. 1 & 4 \\
    \emph{Polypedium} sp. 2 & 2 \\
    \emph{Psychodid} sp. 1 & 1 \\
    \emph{Scyrtes} sp. A & 5 \\
    \emph{Culex} spp. & 4 \\
    \emph{Trentepholia} sp. & 1
  \end{tabular}
\end{table}

After addition of the prey community, all bromeliads were enclosed
with a mesh cage and checked daily for emergence of adults. 

-->

<!-- Our central hypothesis is that the phylogenetic relationships among predatory taxa in this system can be used to interpret their ecology.  Specifically, we test the hypothesis that phylogenetic relatedness is negatively correlated with probability of co-occurance, positively with diet similarity.  Consequently, we might predict that ecosystem function peaks at some intermediate level of phylogenetic diversity -- where predators occur but where their similarity creates complementarity. -->

## Results

### metabolic capacity and phylogenetic distance


```r

## combine by names, then do distances: metabolic matrix
metabolic.matrix <- metabolic[-1]
dimnames(metabolic.matrix)[[1]] <- metabolic[, 1]
pred.abd.distance <- vegdist(metabolic.matrix, method = "euclid")
pred_abd_matrix <- as.matrix(pred.abd.distance)
# occurdist_allpred <-
# data.frame(X=rownames(pred_abd_matrix),pred_abd_matrix)
metabolic_mat <- as.matrix(metabolic.matrix)
# reordered metabolic distance matrix
pred_cor_occurance_metabolic <- cor(t(metabolic_mat))

####### phylogeny matrix #### Calculate distances
allpred.distance.matrix <- cophenetic(predtree_timetree_ages)
## match to abundance matrix names
where_in_phylo <- match(rownames(pred_abd_matrix), rownames(allpred.distance.matrix))
## reorder phylogenetic distance matrix
pred_phylo_matrix <- allpred.distance.matrix[where_in_phylo, where_in_phylo]

# Xlab <- expression(paste('Phylogenetic distance (mean age of common
# ancestor,10'^'6',')')) ####
```



```r
### ---- group means #### go2 <- responses.means(1000)
### write.csv(go2,'randomizations.group.means.csv')
rand.means <- read.csv("../data/predator.div.experiment/randomizations.group.means.csv")
## order these correctly
rand.means$sp.pair <- factor(rand.means$sp.pair, levels = c("elong + andro", 
    "elong + tab", "elong + leech"))
## remove the X column
rand.means <- rand.means[, -1]

### supplementary figure?  ####
meansMelt <- melt(rand.means)
```

```
## Using sp.pair as id variables
```

```r
# #densityplot(~growth+survival+fine+decomp,groups=sp.pair,data=go)
# ggplot(data=meansMelt,aes(x=value,colour=sp.pair))+geom_histogram()+facet_wrap(~variable)

## summarize the randomizations
summarize_randoms <- ddply(.data = meansMelt, .variables = .(sp.pair, variable), 
    summarize, mean = mean(value), lower = quantile(value, probs = c(0.025)), 
    upper = quantile(value, probs = c(0.975)))
```




```r
PD <- pred_phylo_matrix[lower.tri(pred_phylo_matrix)]
occurance_phylo_lm <- lm(pred_cor_occurance_metabolic[lower.tri(pred_cor_occurance_metabolic)] ~ 
    PD)
occur_phylo_summary <- summary(occurance_phylo_lm)
# mantel.test(pred_phylo_matrix,pred_cor_matrix)
```


Predators which are closer in the phylogeny are more likely to occur in the same bromeliads, and to do so with a similar overall metabolic capacity.(F~1,89~=3.9381,P=0.0503).

### diet similarity and phylogenetic distance

```r
# Check for TRUE ZEROS in cast matrix.

# trial.list <- split(foodweb,foodweb$predator.names)
# sapply(trial.list,nrow) need predators as columns, herbivores as rows
foodweb.cast <- dcast(data = foodweb, formula = Prey.species ~ predator.names, 
    value.var = "eaten.numeric", fun.aggregate = sum)
# remove species names
foodweb.matrix <- as.matrix(foodweb.cast[, -1])
# have better names
dimnames(foodweb.matrix) <- list(foodweb.cast[[1]], names(foodweb.cast)[-1])
foodweb.matrix <- foodweb.matrix[, -ncol(foodweb.matrix)]  ## last column was an NA predator.
# make the distance matrix -- with the jaccard index?  start by getting
# the predators from the foodweb data that are actually in the experiment:
location_exp_predators <- which(dimnames(foodweb.matrix)[[2]] %in% c("Tabanidae.spA", 
    "Hirudinidae", "Leptagrion.andromache", "Leptagrion.elongatum"))
## vegdist will calculate differences among rows, so transpose
experiment_predators_diet <- t(foodweb.matrix[, location_exp_predators])
## better to rename and reorder to resemble output of cophenetic
## phylogenetic distances:
predators.in.exp <- prune_predators()
phylodist <- cophenetic(predators.in.exp)
## they should also be in the same sequence:
experiment_pred_diet_reordered <- experiment_predators_diet[match(rownames(experiment_predators_diet), 
    rownames(phylodist)), ]
## finally, calculate distance
distances <- vegdist(experiment_pred_diet_reordered, method = "jaccard", diag = TRUE)
## make a distance matrix so lower.tri subsetting works
dist.mat <- as.matrix(distances)
```



```r
PD <- phylodist[lower.tri(phylodist)]
diet_sim_phylo <- lm(dist.mat[lower.tri(dist.mat)] ~ PD)
diet_phylo_summary <- summary(diet_sim_phylo)
```


Phylogenetic distance was not correlated with similarity in diet (F~1,4~=0.2807,P=0.6243).  Indeed, all predators in this system appeared to feed readily on a wide range of prey species.

### Ecosystem-level effects and phylogenetic distance

All increases in predator phylogenetic diversity beyond damselflies resulted in a reduction of prey mortality; however, these did not reduce predator survivorship.



### Figures


```r
plot(pred_abd_matrix[lower.tri(pred_abd_matrix)] ~ jitter(pred_phylo_matrix[lower.tri(pred_phylo_matrix)], 
    amount = 5), xlab = "phylogenetic distance", ylab = "euclidian distance between total metabolic capacity")
```

![plot of chunk metabolic_cap_fig](figure/metabolic_cap_fig.png) 




```r
plot(dist.mat[lower.tri(dist.mat)] ~ jitter(phylodist[lower.tri(phylodist)], 
    amount = 10), xlab = "phylogenetic distance", ylab = "jaccard distance between feeding trials")
```

![plot of chunk feeding_trial](figure/feeding_trial.png) 



```r
# distances of L. elongatum to everything:
Le_distances <- sort(phylodist["Leptagrion.elongatum", ])
lkup <- data.frame(sp.pair = levels(summarize_randoms$sp.pair), Time = Le_distances[-1])
summarize_randoms_phylo <- merge(summarize_randoms, lkup)
ggplot(subset(summarize_randoms_phylo, summarize_randoms_phylo$variable == "survival"), 
    aes(x = Time, y = mean)) + geom_errorbar(aes(ymin = lower, ymax = upper), 
    width = 0) + geom_point(size = 3) + ylab("Mean treatment difference, Control-Treatment") + 
    xlab("Time (Mya)")
```

![plot of chunk FIG_PD_experiment](figure/FIG_PD_experiment.png) 




### Tables
#### Table 1: phylogenetic distance effects on the correlation of metabolic capacity among predators.

```r
pander(aov(occurance_phylo_lm), caption = "")
```


----------------------------------------------------------
    &nbsp;       Df   Sum Sq   Mean Sq   F value   Pr(>F) 
--------------- ---- -------- --------- --------- --------
    **PD**       1    0.3631   0.3631     3.938   0.05028 

 **Residuals**   89   8.205    0.0922                     
----------------------------------------------------------



#### Table2: 

```r
pander(aov(diet_sim_phylo), caption = "")
```


----------------------------------------------------------
    &nbsp;       Df   Sum Sq   Mean Sq   F value   Pr(>F) 
--------------- ---- -------- --------- --------- --------
    **PD**       1   0.002891 0.002891   0.2807    0.6243 

 **Residuals**   4    0.0412   0.0103                     
----------------------------------------------------------



## Discussion



## Works Cited
