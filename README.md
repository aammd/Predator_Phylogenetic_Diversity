[![DOI](https://zenodo.org/badge/9960337.svg)](https://zenodo.org/badge/latestdoi/9960337)

# Predator phylogenetic diversity decreases predation rate via antagonistic interactions

Manuscript: [md](doc/predatordiversity.md), [pdf](doc/predatordiversity.pdf)
Supplementary material : [md](doc/SuppMatt.md), [pdf](doc/SuppMatt.pdf)

## About this project

When predator species occur in the same place, what happens? A single predator species can have important impacts on the prey species in a community. But, when two or more predators are present, those effects become more uncertain. This is because the predators can interact with each other -- either directly, by eating each other, or indirectly, by modifying prey behaviour. Is there any way to predict what will happen?

One possibility comes from the field of "phylogenetic community ecology". This approach suggests that the evolutionary relationships among organisms can help predict their effect on a community. 

In our experiment, we looked at pairs of predators inside the leaves of bromeliads, water-carrying plants which grow in southern Brazil. For each predator pair, we measured the distance between each predator. We related that difference to three kind of predator impacts on the community:

* **distribution** -- do these predators live in the same place?
* **diet** -- do these predators eat the same thing?
* **effect on the community** -- do they do the same thing to the bromeliad ecosystem? and when they are together, is the effect more or less than you would expect? 

![fig](Figures/fieldexperiment.jpg)
_Each one of these small enclosures contains a bromeliad. The bromeliads were stocked with the same starting insect community, then were given one of three different predator treatments._

## Reproducing this manuscript.

This repository contains all the data, code, and text for this manuscript. The manuscript is created by a reproducible workflow using `remake`, created by [Rich Fitzjohn](https://github.com/richfitz). Learn more about how to use it yourself [here](https://github.com/richfitz/remake)

### First, install devtools
```r
## install devtools, if you don't have it
# install.packages("devtools")
devtools::install_github("richfitz/remake")
```

### Package dependencies
This project uses lots of other R packages to organize the data and perform analyses. Install them like this: 

```r
remake::install_missing_packages()
```

Note that you may require the github version of [`rfigshare`](https://github.com/ropensci/rfigshare/), i.e. `0.3.7.99` or higher

### Creating the project

The last step is to create the final project. To do that, run

```r
remake::make()
```

This will run all the models and simulations, build figures, and compile the final pdf output of the main manuscript and the supplementary figures.

## Data

All of the data for this paper is available on Figshare under a CC-BY licence:

* MacDonald, Andrew; Romero, Gustavo; Srivastava, Diane (2016): Feeding trials of bromeliad invertebrates. figshare.
https://dx.doi.org/10.6084/m9.figshare.3978783.v1

* MacDonald, Andrew (2016): Bromeliad predator phylogeny. figshare.
https://dx.doi.org/10.6084/m9.figshare.3980349.v1

* MacDonald, Andrew; Srivastava, Diane; Romero, Gustavo (2016): Predator diversity and bromeliad communities: experimental results. figshare.
https://dx.doi.org/10.6084/m9.figshare.3983964.v2

## Licenses

The original data, analysis techniques and writing in these documents are &copy; MacDonald, Srivastava and Romero, 2013.

<a rel="license" href="http://creativecommons.org/licenses/by/2.5/ca/deed.en_GB"><img alt="Creative Commons Licence" style="border-width:0" src="http://i.creativecommons.org/l/by/2.5/ca/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Predator Phylogenetic Diversity</span> by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">A. Andrew M. MacDonald, D.S. Srivastava and G.Q. Romero</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/2.5/ca/deed.en_GB">Creative Commons Attribution 2.5 Canada License</a>.

We release all code (`.R` scripts in [`src`](src/)) under the MIT [license](LICENSE)
