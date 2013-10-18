%Predator phylogenetic diversity decreases predation rate via antagonistic interactions
%A. Andrew M. MacDonald, Diane S. Srivastava, Gustavo Q. Romero





```r
# dropping a record that seems to have been 90% decomposed!
pd[which(pd$decomp > 0.7), "decomp"] <- NA
## just to make sure: with(pd,table(treatment)) head(pd)
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


```r
####### metabolic matrix #### we need to calculate two distance matrices: 1)
####### metabolic capacity distance 2) phylogenetic distance

## metabolic matrix -- the 'distance' between predator co-occurance, measured
## as metabolism remove the first column -- it's species names
metabolic.matrix <- metabolic[-1]
## put that name column as dimnames
dimnames(metabolic.matrix)[[1]] <- metabolic[, 1]

## now that metabolic capacity is set up, there are several ways for us to go
## forward: euclidian distance, or maybe correlations?

## euclidian distance between metabolic densities
pred.abd.distance <- vegdist(metabolic.matrix, method = "euclid")
occur_matrix <- as.matrix(pred.abd.distance)  # convert to matrix

## correlations between metabolic densities
metabolic_mat <- as.matrix(metabolic.matrix)
# reordered metabolic distance matrix occur_matrix <- cor(t(metabolic_mat))

####### phylogeny matrix #### Calculate distances
allpred_phylodist <- cophenetic(predtree_timetree_ages)

######## 
```



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
emptyRow <- which(rowSums(foodweb.matrix) == 0)
foodweb.matrix <- foodweb.matrix[-emptyRow, ]
# make the distance matrix -- with the jaccard index?  finally, calculate
# distance
distances <- vegdist(t(foodweb.matrix), method = "jaccard", diag = TRUE)
## make a distance matrix so lower.tri subsetting works
diet_dist_mat <- as.matrix(distances)
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
##### 
```



```r
## we need to merge together several matrices: metabolic occurance + predator
## phylogenetic distance diet similarity + predator phylogenetic distance
## experiment randomization results + predator phylogenetic distance

## note that the nomeclature of the columns keeps `sp.pair` as the only
## shared name among columns.  metabolic occurance ####
metabolic_df <- melt(occur_matrix)[melt(upper.tri(occur_matrix))$value, ]
names(metabolic_df) <- c("metapred1", "metapred2", "metadistance")
metabolic_df$sp.pair <- paste(metabolic_df$metapred1, metabolic_df$metapred2, 
    sep = "_")


## Phylogenetic distance ####
allpred_phylodist_df <- melt(allpred_phylodist)[melt(upper.tri(allpred_phylodist))$value, 
    ]
names(allpred_phylodist_df) <- c("phylopred1", "phylopred2", "phylodistance")
allpred_phylodist_df_RH <- allpred_phylodist_df
allpred_phylodist_df_LH <- allpred_phylodist_df
allpred_phylodist_df_RH$sp.pair <- paste(allpred_phylodist_df_RH$phylopred1, 
    allpred_phylodist_df_RH$phylopred2, sep = "_")
allpred_phylodist_df_LH$sp.pair <- paste(allpred_phylodist_df_LH$phylopred2, 
    allpred_phylodist_df_LH$phylopred1, sep = "_")

## Diet similarity ####
diet_df <- melt(diet_dist_mat)[melt(upper.tri(diet_dist_mat))$value, ]
names(diet_df) <- c("dietpred1", "dietpred2", "dietdistance")
diet_df$sp.pair <- paste(diet_df$dietpred1, diet_df$dietpred2, sep = "_")
## we also need to know how many trials each predator has in common:
incommon <- t(foodweb.matrix > 0) %*% (foodweb.matrix > 0)
incommon_df <- melt(incommon)[melt(upper.tri(incommon))$value, ]
names(incommon_df) <- c("commonpred1", "commonpred2", "Ncommon")
incommon_df$sp.pair <- paste(incommon_df$commonpred1, incommon_df$commonpred2, 
    sep = "_")

#### randomization results #### distances of L. elongatum to everything:
Le_distances <- sort(allpred_phylodist["Leptagrion.elongatum", ])
## a lookup table to pair spp leves with time-since-divergence
lkup <- data.frame(sp.pair = levels(summarize_randoms$sp.pair), Time = Le_distances[c("Leptagrion.andromache", 
    "Tabanidae.spA", "Hirudinidae")])

#### merging #### metabolic occurance + predator phylogenetic distance
metabolic_occur_phylo1 <- merge(metabolic_df, allpred_phylodist_df_LH)
metabolic_occur_phylo2 <- merge(metabolic_df, allpred_phylodist_df_RH)
metabolic_occur_phylo <- rbind(metabolic_occur_phylo1, metabolic_occur_phylo2)
## diet similarity + predator phylogenetic distance
diet_df1 <- merge(diet_df, incommon_df)

diet_similarity_phylo1 <- merge(diet_df1, allpred_phylodist_df_LH)
diet_similarity_phylo2 <- merge(diet_df1, allpred_phylodist_df_RH)
diet_similarity_phylo <- rbind(diet_similarity_phylo1, diet_similarity_phylo2)
## experiment randomization results + predator phylogenetic distance
## diet_df1$sp.pair[!diet_df1$sp.pair%in%diet_similarity_phylo$sp.pair] as
## this code shows, small lepts are not in the running yet
summarize_randoms_phylo <- merge(summarize_randoms, lkup)

##### 
```


### metabolic capacity and phylogenetic distance


```r
meta_phylo_lm <- with(metabolic_occur_phylo, lm(metadistance ~ phylodistance))
meta_phylo_lm_summary <- summary(meta_phylo_lm)
```



```r
nodeages <- lapply(list.files(path = "../data/TreeData/", pattern = "*.csv", 
    full.names = TRUE), read.csv)
names(nodeages) <- list.files(path = "../data/TreeData/", pattern = "*.csv")
nstudies <- sapply(nodeages, nrow)
names(nodeages)[which(nstudies > 1)]
```

```
## [1] "insects.to.leeches.csv"            
## [2] "odonata-Tabanidae.csv"             
## [3] "tabanidae_culidicae_ie_Diptera.csv"
```

```r
n.nodes <- length(nodeages)
```


We identified 14 in the 2008 dataset as predators. These predators vary in taxonomic relatedness: from congeners (_Bezzia_ sp. (Diptera:Ceratopogonidae) with two species, _Leptagrion_ sp. (Odonata:Coenagrionidae) with three) to confamilials (three species of Tabanidae and two of Empididae, all Diptera). Three families of Diptera are represented by a single species each: Dolichopodidae, Corethrellidae and Chironomidae. The deepest taxonomic divide is between all insects present and a species of leech (Annelida:Hirudinidae). Node age data was available for all but the shallowest nodes of the tree, where either a lack of taxonomic information (e.g. Tabanidae) or a lack of phylogenetic studies (e.g. _Leptagrion_) prevented more information from being included.  These branches were left as polytomies, and were all assigned identical, arbitrary and short branch lengths (15 Mya).

We obtained node age estimates for all 7 internal nodes of the tree.  These were usually provided by only a single study, with more studies available for deeper nodes: Insecta--Hirudina (5), Odonata--Tabanidae (4) and Tabanidae--Diptera (7)

Predators which are closer in the phylogeny are not more likely to occur in the same bromeliads (F~1,89~=1.5558,P=0.2155).

### diet similarity and phylogenetic distance



```r
diet_phylo_lm <- with(diet_similarity_phylo, lm(dietdistance ~ phylodistance, 
    weights = Ncommon))
diet_phylo_lm_summary <- summary(diet_phylo_lm)
## test a squared term with
```


All predators showed a very generalist diet breadth.  However, more phylogenetically distinct predators preferred slightly more distant prey, as measured by euclidian distance between feeding trial outcomes (F~1,19~=5.1641,P=0.0349)  Regression was weighted by the number of trials conducted.


<!-- 
Phylogenetic distance was not correlated with similarity in diet (F~

```

Error in eval(expr, envir, enclos) : 
  object 'diet_phylo_summary' not found

```

,

```

Error in eval(expr, envir, enclos) : 
  object 'diet_phylo_summary' not found

```

~=

```

Error in eval(expr, envir, enclos) : 
  object 'diet_phylo_summary' not found

```

,P=

```

Error in pf(diet_phylo_summary$fstatistic[1], diet_phylo_summary$fstatistic[2],  : 
  object 'diet_phylo_summary' not found

```

).  Indeed, all predators in this system appeared to feed readily on a wide range of prey species.
-->

### Ecosystem-level effects and phylogenetic distance

All increases in predator phylogenetic diversity beyond damselflies resulted in a reduction of prey mortality.

predator addition treatments did not differ strongly from predator-free controls. We did not find significant differences for FPOM, decompositon, or bromeliad growth. However, we did find results for N15 uptake into bromeliads. Our strongest differences were in insect survivorship, which decreased in all predator treatments relative to control. 



### Figures


```r
ggplot(metabolic_occur_phylo, aes(x = phylodistance, y = metadistance)) + geom_point() + 
    stat_smooth(method = "lm", se = FALSE) + xlab("phylogenetic distance") + 
    ylab("correlation between total metabolic capacity")
```

![plot of chunk FIG_metabolic_occurance_as_phylo](figure/FIG_metabolic_occurance_as_phylo.png) 




```r
ggplot(data = diet_similarity_phylo, aes(y = dietdistance, x = phylodistance, 
    size = Ncommon)) + geom_point() + scale_size(range = c(2, 6)) + ylab("Euclidian distance between feeding trials") + 
    xlab("phylogenetic distance") + stat_smooth(method = "lm", aes(weight = Ncommon))
```

![plot of chunk FIG_feeding_trial_as_phylo](figure/FIG_feeding_trial_as_phylo.png) 

```r
# plot(dist.mat[lower.tri(dist.mat)]~
# jitter(phylodist[lower.tri(phylodist)],amount=10), xlab='phylogenetic
# distance',ylab='jaccard distance between feeding trials')
```



```r
ggplot(subset(summarize_randoms_phylo, summarize_randoms_phylo$variable == "survival"), 
    aes(x = Time, y = mean)) + geom_errorbar(aes(ymin = lower, ymax = upper), 
    width = 0) + geom_point(size = 3) + ylab("Mean treatment difference, Control-Treatment") + 
    xlab("Time (Mya)")
```

![plot of chunk FIG_PD_experiment_nonadditive](figure/FIG_PD_experiment_nonadditive.png) 

```r
# ggplot(summarize_randoms_phylo,
# aes(x=Time,y=mean))+geom_errorbar(aes(ymin=lower,
# ymax=upper),width=0)+geom_point(size=3)+ylab('Mean treatment difference,
# Control-Treatment')+xlab('Time (Mya)')+facet_wrap(~variable)
```




```r
pd_long <- melt(pd[names(pd) %in% c("treatment", "total.surv", "fine", "decomp", 
    "growth", "N")], id.vars = "treatment")

plotmaker <- function(resp, kill_trtnames = TRUE, label) {
    ggplot(pd_long, aes(y = value, x = treatment)) + stat_summary(fun.y = mean, 
        fun.ymin = min, fun.ymax = max, geom = "pointrange", subset = .(variable == 
            resp)) + geom_hline(x = 0, colour = "grey") + ylab(label) + coord_flip() + 
        if (kill_trtnames) 
            theme(axis.text.y = element_blank(), axis.title.y = element_blank())
}

surv <- plotmaker(resp = "total.surv", kill_trtnames = FALSE, label = "prey survival")
N <- plotmaker("N", label = "Nitrogen")
growth <- plotmaker("growth", label = "growth (mm)")
decomp <- plotmaker("decomp", label = "decomposition \n (g)")
fine <- plotmaker("fine", label = "production of \n FPOM (g)")
grid.arrange(surv, N, growth, decomp, fine, ncol = 5, widths = unit(c(2, rep(1, 
    4)), "null"))
```

```
## Warning: Removed 1 rows containing missing values (stat_summary).
## Warning: Removed 1 rows containing missing values (stat_summary).
```

![plot of chunk FIG_experiment_responses](figure/FIG_experiment_responses.png) 

```r

```



controls not really differen



## Discussion



## Works Cited
