---
title: "Predator phylogenetic diversity decreases predation rate via antagonistic interactions"
author: "A. Andrew M. MacDonald; Gustavo Q. Romero; Diane S. Srivastava"
fontsize: 12pt
output:
  pdf_document:
    includes:
      in_header: formatting/myheader.tex
    latex_engine: xelatex
  md_document: default
  html_document: default
  word_document:
    reference_docx: formatting/reference.docx
geometry: margin=1in
bibliography: /home/andrew/Documents/reference/Mendeley_reference_lists/@MS_pdpaper.bib
---



## Introduction

Predators can have strong top-down effects, both on community structure and
ecosystem processes [@Estes2011]; however their effects in combination are not
well understood. The effect of predator species diversity on communities is often stronger or weaker than the combined effects of
individual predator species [@Sih1998a;@Ives2005]. These nonadditive effects of predator
diversity occur when predators interact directly with each other, or indirectly
via prey species. For example when predators feed directly on each
other (intra-guild predation), consume the same prey (resource competition) or
modify the behaviour of predators or prey via nonconsumptive (i.e. trait-
mediated) interactions [@Sih1998a;@Griswold2006;@Nystrom2001]. Nonadditive effects can be positive or negative: e.g. if one predator causes behavioral shifts
in prey that increase their chance of being eaten by another predator species. While there are many possible mechanisms underlying the effect of predator composition, we lack a means of
predicting _a priori_ the strenght and direction of predator diversity on communities and ecosystem functions.

One candidate predictor of the effect of predator combinations is predator
phylogenetic diversity. The measurement of phylogenetic diversity has become a
popular means for ecologists to make inferences about ecological and
evolutionary mechanisms behind observed patterns in natural communities
[@Cavender-Bares2009]. For example, the phylogenetic diversity of plant
communities is a better predictor of productivity than is either species
richness or diversity [e.g. @Cadotte2009;@Cadotte2008;@Godoy2014]. A central
assumption of this approach is that increased phylogenetic distance implies
increased ecological dissimilarity -- either in the form of differences in
species niches, interactions, or functional traits. When this is true, high
phylogenetic diversity leads to complementarity between species, resulting in increased
ecosystem functioning [@Srivastava2012c]. Despite the prevalence of phylogenetic
community ecology and the importance of predators to natural systems, the
phylogenetic diversity of local predator assemblages has rarely been measured
[@Bersier2008;@Naisbit2011]. Many studies of phylogenetic signal in predator
traits focus on whole clades, rather than local assemblages (e.g. *Anolis*
lizards [@Knouft2006], warblers [@Bohning- Gaese2003], tree boas
[@Henderson2013] and wasps [@Udriene2005]) making it difficult to connect these
results to predator effects at the scale of a local community. These 
clade-specific studies often find weak evidence for phylogenetic signal in
ecologically- relevant traits; in contrast, studies at the level of the whole biosphere
[@Gomez2010;@Bersier2008] demonstrate that related organisms often have similar
interspecific interactions -- i.e. related predators often consume similar prey. In order to understand how predator diversity will affect community composition and ecosystem function at the local scale, we need to understand both their distribution and their interspecific interactions alone and in combination.

Within a local community, the effect of predator species diversity will depend on three factors: how predators are distributed, how they interact with prey, and how they behave in combination. To the extent that phylogenetic relationships are correlated with all of these factors, they can predict the impact of predator diversity on communities. For instance, phylogeny could constrain predator species composition if more distant
relatives have more distinct fundamental niches, while close relatives are too
similar to co-exist [@Webb2002;@Emerson2008]. When predators do co-occur, phylogeny may correlate with their feeding behavior, such that more closely related predators consume more similar prey. Diet overlap (shared prey species between predators) will depend on the feeding traits and nutritional 
requirements of predators -- both of which may be phylogenetically conserved. If this is the case, then predator assemblages with higher
phylogenetic diversity will show greater prey consumption and therefore a stronger top-
down effect on ecosystem function [@Finke2008a]. In some cases, predator
diets may extend to include other predators, leading to direct negative
interactions such as intraguild predation, which may also have a phylogenetic
signal [@Pfennig2000]. 

We examined the predator community using a natural mesocosm: the community
of invertebrates living within bromeliads. Bromeliads (Bromeliaceae) are
epiphytic plants native to the Neotropics. Many bromeliad species contain
water and detritus; the decomposition of this detritus supplies nutrients for
the bromeliad [@Reich2003]. The small size of these habitats permits direct
manipulations of entire food webs, manipulations which would be difficult in
most natural systems.  Within this aquatic food web, damselfly larvae (e.g.
*Leptagrion* spp., Odonata:Coenagrionidae) are important predators; their
presence dramatically alters community dynamics (e.g. decreases insect
emergence [@Starzomski2010] and increases nutrient cycling [@Ngai2006]). However, other predators are also found in bromeliads, including large predaceous fly larvae (Diptera: Tabanidae) and predatory leeches.

We used a series of observations, lab feeding trials, and manipulative field
experiments to measure how the phylogenetic diversity of the predator
assemblage predicts community composition and ecosystem function.  We test
three related hypotheses concerning similarity in distribution, diet and top-
down ecosystem effects of predators, 

1. *Distributional similarity*: closely-related predators may occur together more
frequently than less-related predators if there is a strong phylogenetic
signal to habitat requirements.  Alternatively, very closely related species
may never co-occur because high overlap in ecological niches results in
competitive exclusion.

2. *Diet similarity*: similarity in diet (as measured by feeding trials)
decreases with phylogenetic distance if diet is conserved.
Alternatively,  closely related species may have evolved different diets to
allow coexistence.

3. *Ecosystem-level effects*: our experiments at the level of the whole habitat patch (i.e. a single bromeliad) allow us to test hypotheses about direct and indirect effects of predator combinations:
    (a) Closely-related predators will have similar effects on the community. This will occur if related predators share similar trophic interactions (e.g. predation rate, diet similarity). Our monoculture treatments allow us to assess the effect of each predator on both a complete prey community and ecosystem function.  
    (b) More phylogenetically diverse predator assemblages will show a stronger non-additive effect. This will occur if phylogenetic distance correlates with increasing trait difference, and if this trait difference is enough to lead to complementarity. At the extreme, differences between predators may lead to IGP among predators. By comparing treatments with pairs of predators to treatments which received a monoculture of each predator, we are able to estimate additive and nonadditive effects. 

## Methods

## Study Design

We collected three datasets to address each of these questions. We examined distributional similarity among predator species (Question 1) by making observations of predator distribution among habitat patches. We examined diet similarity with a series of no-choice feeding trials in under laboratory conditions. Finally, we examined the effects on predators on whole communities with a field experiment, in which predators were added to habitat patches containing standardized communities of prey. This experiment included both single species treatments and two species treatments; the latter were chosen to create the widest possible range of phylogenetic diversity. 

In each dataset, we related the results to published phylogenies accessed from
"timetree.org", an online database of published  molecular time estimates
[@Hedges2006]. Node age data was available for all but the youngest nodes,
where either a lack of taxonomic information (e.g. Tabanidae) or a lack of
phylogenetic study (e.g. _Leptagrion_) prevented more information from being
included.   These branches were left as polytomies, and were all assigned
identical, arbitrary and short branch lengths (15 Mya).

We conducted all observations and experiments in Parque Estadual da Ilha do
Cardoso ($25^{\circ} 03^{\prime}$ S, $47^{\circ}53^{\prime}$ W), a 22.5 ha
island off the south coast of São Paulo state, Brazil. We worked in a closed
coastal forest (_restinga_) in the understory of which grows the abundant 
_Quesnelia arvensis_ Mez. (Bromeliaceae). _Quesnelia_ is a large terrestrial bromeliad that catches and holds rainwater (phytotelmata), accumulating up to 2.8 L of rainwater in a single plant. Our observational survey found more than 47 species of macroinvertebrates in these aquatic communities [@Romero2010].
This diversity encompasses multiple trophic and functional groups: filter feeders (Diptera:Culicidae); detritivores including shredders
(Diptera:Tipulidae, Trichoptera), scrapers (Coleoptera:Scirtidae), and collectors
(All Diptera:Chironomidae, Syrphidae, Psychodidae). These species are the main prey for a 
diverse predator assemblage of at least three species of damselfly larvae (_Leptagrion_ spp., Zygoptera:Coenagrionidae), two species of predatory Horse Fly larvae (Diptera:Tabanidae), and two
species of leech (Hirudinidae). 

## Data collection

### Question 1: Distributional similarity

To examine distributional similarity among predator species, we used a
detailed survey of bromeliad communities. in 2008 each bromeliad was dissected
and washed to remove invertebrates and the resulting water was filtered
through two sieves (250 and 850 µm), which removed particulate organic matter
without losing any invertebrates. All invertebrates were counted and
identified to the lowest taxonomic level possible. The body length of all
individuals was measured, when possible for small and medium-sized taxa (< 1cm
final instar) and always for large-bodied taxa (> 1 cm final instar).

### Question 2: Diet Similarity


To examine diet similarity among predator species, we fed prey species to predators in laboratory feeding trials. We conducted 314 feeding trials of 10 predator taxa and 14 prey taxa between March and April 2011.  We  covered all potential predator-prey pairs present in the experiment
(described below), and attempted to perform all other trials whenever possible. However, due to the rarity of some taxa many predator-prey pairs were not possible; we tested 56 pairwise combinations.  Most trials were replicated at least five times, but the number of replicates ranged from 1 to 11. We placed
predators together with prey in a 50ml vial, with a leaf or stick for
substrate. The only exception was the tabanid larvae, which we
placed between two vertical surfaces to imitate the narrow space found in
bromeliad leaf axils (their preferred microhabitat).  Generally our trials contained a single predator and a
single prey individual, except in the case of very small prey (_Elpidium_ sp.)
or predators (_Monopelopia_ sp.) in which case we increased the density.  We
replicated each combination up to five times where possible, and allowed 24 hours for
predation to occur.

### Question 3: Community effect experiment

Our third question had two parts: (a) how do predator species differ in their
effects on the whole community and (b) does predator diversity show
nonadditive effects on the community, and do these nonadditive effects
increase with phylogenetic distance? 

#### Experimental design

In this experiment we focused on the four most abundant large predators found in this community: _Leptagrion andromache_ and _Leptagrion elongatum_ (Odonata: Coenagrionidae), a predatory Tabanid fly (Diptera:Tabanidae:_Stibasoma_ **correct?**) and a predatory leech. We combined these species in eight treatments: predator species alone in bromeliads (relevant to part a) and predator species paired to maximize the
range of phylogenetic distance (part b). Specifically, these pairs were: two congeneric damselflies (*Leptagrion
andromache* and *Leptagrion elongatum*), two insects (*L. elongatum* and a
Tabanid predatory fly), and two invertebrates (*L. elongatum* and a predatory
leech).  We used five replicate bromeliads for each treatment (8 treatments, n=5).  In order to control for
differences in body size and feeding rate among predator species, we used a
substitutive design which maintained the same predator metabolic capacity in all
replicates (see below). Substitutive experiments often hold total abundance
constant, but when species differ substantially in body size - as in this
experiment - allometric effects of body size on feeding rate can confound
detection of effects based on trophic traits or species interactions, and
standardizing to community metabolic capacity is preferred [@Srivastava2009a].
This experiment allows the estimation of the effect of each predator species
(monoculture treatments), as well as the detection of non- additive effects in
predator combinations. Species co-occurrence is often measured in terms of non-random patterns of
species presence/absence or abundance, but such measures will only be poorly related
to the functional effects of species when species differ substantially in body
size.  Integrating the allometric relationship between body size and feeding
rate [@Brown2004; @Wilby2005] over all individuals of a species allows estimates
of "metabolic capacity", or the potential energy requirements of a species
[@Srivastava2009a]. Metabolic capacity is equal to individual body
mass raised to the power of 0.69 (an insect-specific exponent determined by Peters 19xx and confirmed by Chown et al, [-@Chown2007]); this reflects the nonlinearity of feeding rate
on body size across many invertebrate taxa. We used metabolic capacity to inform
both our observational results and our experimental design (details below), with the exception
of our feeding trial data.  This is because the feeding trials were intended to
measure which prey our predators ate, rather than their feeding rate (only the
latter should scale with metabolic capacity).

In Feburary 2011 we collected bromeliads with a volume between 90 and 200ml,
thoroughly washed them to remove organisms and detritus and soaked them for 12 hours in a
tub of water. We then hung one bromeliad for 48 hours to dry. One bromeliad dissected
after this procedure contained no insects. Each bromeliad was supplied with
dried leaves, simulating natural detritus inputs from the canopy. In order to
track the effects on detrital decomposition on bromeliad nutrition, we enriched
these leaves with ^15^N by fertilizing five *Plinia cauliflora* (Jabuticaba, Myrtaceae) 
plants with 40ml pot^-1^ day^-1^ of 5g L^-1^ ammonium sulphate containing 10%
atom excess of ^15^N over 21 days. Whole leaves were then picked from plants and
air-dried until constant weight, and then soaked for three days and the water
discarded. About 1.5 g of leaves were placed in each bromeliad 
(1.5g ± 0.02). 

Each bromeliad was stocked with a representative insect community. The densities
of each prey taxon were calculated from the 2008 observational dataset, using
data from bromeliads of similar size to those in our experiment.  All densities
used were within the range of these calculated abundances, and all experimental
bromeliads received the same insect community.  Halfway through the experiment,
insects were added to bromeliads a second time to simulate the continuous
oviposition that characterizes the system.  Throughout the experiment, all bromeliads were enclosed
with a mesh cage topped with a malaise trap and checked daily for emergence of
adults. At the end of the experiment we completely dissected our bromeliads, collecting all invertebrates and detritus remaining inside.

To quantify the effect of predators on ecosystem function, we measured five community and ecosystem response variables: production of fine
particulate organic matter (FPOM), decomposition of coarse detritus, bromeliad
growth, uptake of detrital nitrogen into bromeliad tissue, and survival of invertebrate prey (emerged adults +
surviving larvae). We measured the decrease in coarse detritus, and the increase in fine, by separating the collected detritus on a sieve and air drying it to constant weight before weighing. We measured uptake of labelled detrital nitrogen by analysing three samples of bromeliad leaves. Finally, we quantified the species composition and survivorship of invertebrate prey by adding together counts of emerging adult insects with counts of surviving larvae.

## Data analysis

### Question 1 and 2: similarity in distribution and diet

We quantified the effect of phylogenetic distance on each of distributional (Question 1) and diet (Question 2) similarity.  First, we calculated phylogenetic distance between each pair of species, then fit several functions to the relationship between phylogenetic diversity an either distributional or diet similarity (linear, constant, and several appropriate nonlinear functions).  We compared these models using AIC, selected the best model, and generated confidence intervals as appropriate (parametric or bootstrap for linear and nonlinear, respectively). We evaluated both distributional and diet similarity between predators using Pianka's index of niche overlap [@Pianka1974]:

$O_{kl}=\dfrac{\sum_i^n{p_{il} p_{ik}}}{\sqrt{\sum_i^n{p_{il}^2} \sum_i^n{p_{ik}^2}}}$

For each pair of predators, $p_{ik}$ and $p_{il}$ represent the preference of
predator $k$ (or $l$) for resource or habitat $i$. When quantifying distributional similarity, $n$=25 bromeliads surveyed in the observational data; when quantifying diet similarity, the number of resources ($n$) is defined as the total number of prey
species assayed with both predator taxa.  In the survey data, preference ($p_{ik}$) is defined as the proportion of a predator's total metabolic capacity found in a particular bromeliad; in diet trials it is the
proportion of diet trials (see below) for each predator-prey combination that resulted in prey
mortality.

### Question 3: similarity in community effect

We tested for effects of predator species on community processes, both alone and in combination, with a manipulative experiment where identical communities were exposed to treatments of either a single predator, or a range of phylogenetically-diverse pairs of predators. We divided the analysis of this experiment into three parts, quantifying the effect of phylogenetic distance on prey community similarity, community responses, and nonadditive effect. First, we used Pianka's index (as above) to measure the similarity between surviving prey communities among the four treatments with single predator species, and related this similarity to phylogenetic distance. If predator feeding choices are phylogenetically conserved, then we expect a negative relationship, with close relatives being found with similar communities of prey. 

Second, we examined how predators affected the five community and ecosystem responses we described above, testing in turn the effect of predator presence, number, species identity, and finally phylogenetic diversity. For each response, we combined our treatment levels into four different contrasts, each of which examine a different aspect of predator impact. To test for an effect of predator presence, we contrasted the control treatment (predators absent) with the mean responses of all seven treatments that did contain predators. To test for an effect of predator species number (one or two predators), we contrasted the means of all monocultures with the means of all pair treatments. We compared all four single-species treatments to test for an effect of predator identity, and finally we tested for an effect of increasing phylogenetic diversity among the three two-species treatments. We analyzed each of these responses with one-way ANOVA. 

In our third and final analysis we quantified the non-additive effect of predator species. We calculated this effect as the difference between the
response in bromeliads with both predator species (n=5) and the mean response in bromeliads with either one of these two predator species 
(n=5 for each predator species).  We generated bootstrap confidence intervals for
these nonadditive effects; confidence intervals which do not overlap zero
indicate a significant non-additive effect of a predator combination.

## Results

### Question 1 and 2: similarity in distribution and diet






We did not find any significant relationship between habitat distribution (measured as Pianka's index of niche overlap) among predator species and the phylogenetic distance between them (Figure 1a, F~1,89~=2.39, p=0.13). Indeed we often found multiple predator species co-occurring in the same bromeliads (mean 4.4 ± 2.9 predator species per plant).  This indicates that predator species all have roughly similar habitat distributions at the level of the bromeliad. We found this pattern of broad overlap despite this dataset containing more more species than our other datasets, a total of 14 predator taxa in 25 bromeliads. We were able to sample a wide range of phylogenetic relatedness, including two groups of 
congenerics -- two species of _Bezzia_ sp. (Diptera:Ceratopogonidae) and three species of _Leptagrion_ sp.
(Odonata:Coenagrionidae). There were also two groups of confamilials -- three species of
Tabanidae and two species of Empididae, all Diptera.  Deeper divisions were also present: three families of Diptera are represented by a single predator species each (Dolichopodidae, Corethrellidae and
Chironomidae) and the deepest taxonomic divide is between all insects present and the predatory leeches (Annelida:Hirudinidae).







More phylogenetically distant predators differed in their preference of prey
species, as measured by the niche overlap index (Fig 1b, F~1,26~=19.41, p=0.00016), regression weighted by the number of prey
species assayed.). Among the most common predator taxa (i.e. those used in our experiment,
described below) the damselflies (_Leptagrion andromache_ and _Leptagrion
elongatum_) showed the highest rates of prey consumption (prey consumed in 94.3% and 67.7% of trials, respectively). Despite the declining pattern of phylogenetic distance, the variation in predator feeding behaviour did not translate into a significant difference in the composition of prey species surviving the manipulative experiment 
(Fig 1c, F~1,4~=0.6, p=0.48)

### Question 3: similarity in community effect

Predators had a large effect on prey survivorship: on average all predator
treatments showed XX% lower prey emerging or surviving as
larvae relative to the predator-free control.  Nitrogen transport to bromeliad
leaves was slightly decreased in bromeliads with predators relative to
predator-free controls (XX%), and was only higher than the
control in treatments including Tabanid predators.  We found a similar pattern
for plant growth: on average, predators had a XX% effect
on growth of bromeliad leaves (leaf elongation in mm), though Tabanids seemed
to create a slight increase. The decomposition of coarse detritus and
production of fine organic matter showed no obvious pattern related to the
presence of predators.

Predator combinations tended to have a non-additive effect on our response
variables.  Approximately % more prey survived in polyculture,
on average,  compared to all monocultures.  Nitrogen uptake increased by (%) and bromeliad growth by (%).
Production of fine particulate organic matter increased by % more when predators were present in combination.

We tested the hypothesis that increased phylogenetic distance between members
of a predator pair results in a greater magnitude of nonadditive effect using
randomization tests.  We contrasted the differences of the mean individual
predator treatments from the control with the mean difference of their
pairwise combination from the control. We found the greatest effect for prey
survival: while effects of _L. andromache_ and _L. elongatum_ in combination
were quite similar to the effect of either alone, when _L. elongatum_ was
placed in the same plant as either a Tabanid larva or leeches, on average five
more prey individuals (18% of total prey community) survived till the end of
the experiment (Fig 3).  This effect was smaller among the other variables,
most of which showed confidence intervals from the randomization test which
overlap zero.


### Figures

![niche overlap](../Figures/FIG_1.pdf)

**Figure 1**: Phylogenetic distance and niche overlap among predators. Our measures of niche overlap were: (a) distribution among bromeliads; (b) diet preferences and (c) community composition of surviving prey. We measured distributional similarity (a) by counting all predators in 25 bromeliads, estimating their total metabolic capacity, and calculating niche overlap among all pairs of species. We measured diet preferences (b) for a subset of these predators by offering them various prey in no-choice trials. Finally, we measured community composition of surviving prey (c) at the end of an experiment in which predators were placed in bromeliads with standardized communities (see main text for details). We used Pianka's index of niche overlap and fit various nonlinear models (see Appendix) to the relationship between this index and phylogenetic distance. Solid lines show signifigant model fit, and dashed lines show bootstrap 95% quantiles.

![prey survival](../Figures/FIG_2.pdf)

**Figure 2**: The effect of predators on the survival of prey organisms. We show the effects of predator presence (a), increased number of predators (b), predator species identity (c) and predator species pairs (d, arranged in order of increasing phylogenetic distance). Shaded dots represent grand means for each group; unshaded dots are either treatment means (2a and 2b, n = 5) or individual bromeliads (2c and 2d).

![nonadditive](../Figures/FIG_3.pdf)

**Figure 3**: Phylogenetic distance and non-additive effects of predator combinations. We calculated non-additive effect size by first subtracting treatment means from control (no predators), then subtracting the mean of single-predator treatments from two-predator treatments. A difference of 0 indicates that two-predator treatments resulted in no more prey mortality than would be expected from simply averaging single-predator treatments. Error bars represent bootstrap 95% confidence intervals.


**Table 1** Predator diversity effects on community and ecosystem variables. We measured four community-level variables: total prey survival (both emerged adults and surviving larvae), the breakdown of coarse detritus, the production of fine particulate organic matter (FPOM), and the growth of the bromeliad itself. We contrast treatments in our experimental design in three ways: comparing treatments with predators to those without, contrasting predator species, comparing predator communities of 1 or 2 species, and considering the effects of phylogenetic distance between predators.  \* = p < 0.05, \*\* = p < 0.01

 
 
 
 
| Response | Predator Presence | Identity | Richness | Pairwise PD | 
| -------- | ------------------| ---------|--------- | ---------- | 
| Total prey survival  |   F~1,10~ = 9.07\* | F~3,16~ = 0.6  | F~1,5~ = 1.96 | F~1,13~ = 7.64\* |  
| Decomposition (g)  | F~1,10~ = 0.47 | F~3,15~ = 1.29| F~1,5~ = 0.21 | F~1,13~ = 0.4 |  
| FPOM (g)     | F~1,10~ = 0.92 | F~3,16~ = 0.42 | F~1,5~ = 6.47 | F~1,13~ = 1.35 | 
| Bromeliad growth  | F~1,10~ = 0.51 |F~3,16~ = 0.96 | F~1,5~ = 0.49 | F~1,12~ = 1.29 | 
| Nitrogen cycling  | F~1,10~ = 2 |F~3,16~ = 1.84 | F~1,5~ = 0.5 | F~1,13~ = 0.15 |  
   

## Discussion

In our system, phylogenetically distant pairs of predators are distributed
with the same degree of similarity as phylogenetically similar predators
(Question 1). However, we did find that phylogenetically distant predators had
slightly different diet preferences (Question 2). Interestingly, these
apparent diet preferences in the lab did not create a difference in surviving
species composition in the field (3a).  When we created increasingly
phylogenetically distant pairs of predators in experimental communities we
found that increasing phylogenetic diversity was correlated with an increase
in prey survival (ie decreased predation) (3b).

### Do related organisms occur in different bromeliads? 

Both phylogenetically similar and distinct predators were distributed in a
similar way. This indicates The absence of any signal suggests that either patches do not
differ in variables which matter to the predators, or that predator taxa do
not have strong impacts on each other's distribution. The lack of a
relationship is probably not due to a lack of variation in habitat features
among patches: We know already (CITE) that bromeliads in this and other
systems vary considerably in many habitat variables, such as detritus content,
amount of sunlight, and habitat size. It is more likely that these predator
species are habitat generalists. Organisms which live in small, fluctuation-
prone habitats -- especially if they are long-lived -- may evolve a wide
physiological tolerance to those environmental fluctuations. Therefore we
would not expect a high degree of habitat specificity among these organisms.

Although we found some evidence for negative intraspecific effects in our
experiment, these do not appear to limit predator distribution. This could be
caused by a low encounter rate of predators in natural plants, especially in
larger bromeliads than those used in our experiment. Additionally, negative
effects could still be occurring in nature, but not resulting in mortality.
Indeed, if animals are actually able to adjust their development times and
feeding rates when conditions are unfavourable (and if the presence of a
competing predator creates such unfavourable conditions), then we would expect
to observe more frequent, not less frequent, co-occurances of predators.  Non-
consumptive negative interactions need not result in dissimilar distributions.

In our experimental treatments with paired predators we observed little
predator mortality; this suggests that predator indirect interactions might
reduce predator feeding rates but do not necessarily result in predator
mortality. Our observational data indicate that at the level of the patch
(i.e. a single bromeliad) a wide range of predator phylogenetic diversity is
possible, from very similar to very disparate. This justifies the phylogenetic
diversities we used in our experimental communities, as these are within the
range found in nature.

### Do related organisms have similar diets?

Predators consumed very similar prey, except those most phylogenetically
distinct. There were some slight taxon-specific diet preferences which
accounted for this. Leeches and tabanids showed different patterns of
consumption compared with *Leptagrion* predators: they consumed less
frequently, and notably consumed prey in less than half of trials with *Culex*
(leech) or *Scirtes* (Tabanid).  This may be because these predators lack the
strong jaws and "mask" of odonata, and these two prey species are particularly
active (in the case of culicids) or difficult to handle (scirtids).  Tabanids
in particular differ in microhabitat use from odonates; living deep within
leaf axils, where culicids are rarely found. One of our *Leptagrion*
morphospecies showed a greater preference for harder-bodied prey species (i.e.
Ostracoda, Scirtes and *Phylloicus*, which is a caddisfly.)  All of these
animals are consumed more frequently by this damselfly than by the other
species of _Leptagrion_, while the other damselflies more frequently consumed
*Culex* and *Polypedilum* prey. Thus, our data show some evidence of a
phylogenetic basis for diet dissimilarity, based on the very different traits
of these invertebrate taxa. Traits can be more important than phylogeny *per
se* to a predator's diet: [@Moody1993] found that unrelated decapod species
which were morphologically similar were also functionally similar. Similarly,
[@Rezende2009] found that both body size and phylogeny determined the food web
"compartment" (shared predator-prey interactions) of a predator in a marine
foodweb. In addition, our experimental results are consistent with high
similarity among predator diets: all predator species had comparable effects
on all response variables, including prey species survival.

### Phylogenetic diversity and non-additive effects

Predator pairs which were more phylogenetically distant had a larger negative
nonadditive effect on prey capture.  This is contrary to our hypothesis that
more distant predators would show an increase in prey capture via
complementarity. *L. andromache* did not produce a negative effect in
combination with *L. elongatum*, while more phylogenetically distinct
predators did. It may be that these odonates have behavioural traits that
reduce the probability of their interaction, for example each nymph occupying
a single leaf-well. If this is the case, each damselfly may not experience
many cues indicating the presence of other predators, resulting in no non-
additive interaction.

Odonates can be sensitive to chemical cues of potential predators, which
causes a decrease in feeding rate (Barry and Roberts 2014). However other
research in bromeliads has demonstrated that it is physical contact with other
organisms that reduces damselfly predation rate (Trish).  If this is the case
for *Leptagrion*, then when combined with leeches they may be responding to
frequent contact with those very active predators. Tabanids, however, are
rarely observed outside of a deep leaf axil -- in this case, it may be
chemical cues which are responsible. There may also be a phylogenetic signal
to the chemical cues which the damselflies perceive: i.e. close relatives
(other _Leptagrion_ sp. in this case) might induce less of an effect than
other predators.

Interestingly, the pattern of induced defenses do not line up with predation
risk, as observed in our feeding trials. In feeding trials with leeches,
actual predation was rarely observed -- except in one instance, where the
damselfly ate the leech. However, trait-mediated indirect effects may not
always reflect realized probability of predation: an animal may change
behaviour when exposed to a "predator" which poses little threat (REF).

One limitation of our approach is the focus on a single focal predator, the
odonate *Leptagrion elongatum*, which was common in all of our predator
treatments. It is possible that this species is more sensitive to the presence
of other predators, and therefore shows a larger trait-mediated indirect
effect, than would other species in this community.  However, this is the most
common species in this community and our results indicate that its top-down
effects are likely to be frequently reduced by the presence of other
predators.

## References
