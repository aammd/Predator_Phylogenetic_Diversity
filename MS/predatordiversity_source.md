%Predator phylogenetic diversity decreases predation rate via antagonistic interactions
%A. Andrew M. MacDonald, Diane S. Srivastava, Gustavo Q. Romero





```
## treatment
##         andro       control         elong elong + andro elong + leech 
##             5             5             5             5             5 
##   elong + tab         leech       tabanid 
##             5             5             5
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











Predators which are closer in the phylogeny are more likely to occur in the same bromeliads, and to do so with a similar overall metabolic capacity.(F~1,89~=3.9381,P=0.0503).

### diet similarity and phylogenetic distance






Phylogenetic distance was not correlated with similarity in diet (F~1,4~=0.2807,P=0.6243).  Indeed, all predators in this system appeared to feed readily on a wide range of prey species.

### Ecosystem-level effects and phylogenetic distance

All increases in predator phylogenetic diversity beyond damselflies resulted in a reduction of prey mortality.



### Figures


```
## Error: object 'x' not found
```

```
## Error: object 'm' not found
```

![FALSE](figure/FIG_metabolic_occurance~phylo.png) 



![FALSE](figure/feeding_trial.png) 


![FALSE](figure/FIG_PD_experiment.png) 






## Discussion



## Works Cited
