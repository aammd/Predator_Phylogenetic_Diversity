# R scripts for pd paper 

It would be ideal to have **one R script per dataset**, showing how the dataset is taken from source material and brought into a final form.  This would describe all the process of transforming the data from raw to polished -- including all decisons, such as which rows to merge, renaming, etc.  Then, in the .Rmd document that forms the basis of the paper, only modelling and summarizing need to occur.  There could even be a 'head' R file that is sourced in at the beginning to make it all possible, and to standardize between the figures and the main paper.

* `experimental_data_collate_cleanup.R` is for combining all the different datasets relevant to the **whole bromeliad experiment**, and cleaning them.  It produces `pd_exp_cleaned_data.csv` which contains *all* the data relevant to the experiment in 2011

* `foodweb_merge_cleanup.R` handles all the feeding trial data, and merges it with the leptagrion data.  the output is saved in `data/reorganized_data/reorganized.feeding.trial.data.csv`.  ADD RENAMING

* `cleanup_organization_for_graphing_analysis.R` is for reorganizing, collating all the data from all the sources -- basically, getting the numbers ready for the publication. After this, the stats happen in the MS and the graphing in the figures.

* `foodweb.fn.R` contains functions.  They are used in the analyses presented in the paper.  They are `picture()`, which is good for making a picture of the foodweb, and `prune_predators()`, which is a wrapper for prune.sample from `picante`

* `pd.functions.R` contains functions for analyzing the experiment, specifically the randomization tests.

* `phylogeny.R` reads in a newick tree (arbitrarily ultrametric, or taxonomy tree) and adds branchlengths from data downloaded from [TimeTree](timetree.org)

* `pred.div.R` applies the functions of `pd.functions.R` to the experimental data.  should probably be reworked and added to the main document.

* `predator.cooccurance.R` organizes co-occurrence data from the working group.  produces.  the probability of predators co-occuring as a function of their phylogenetic distance. 