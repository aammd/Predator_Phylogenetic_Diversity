# R scripts for pd paper 

* `experimental_data_collate_cleanup.R` is for combining all the different datasets relevant to the **whole bromeliad experiment**, and cleaning them.  It produces `pd_exp_cleaned_data.csv` which contains *all* the data relevant to the experiment in 2011

* `foodweb_merge_cleanup.R` handles all the feeding trial data, and merges it with the leptagrion data.  the output is saved in `data/reorganized_data/reorganized.feeding.trial.data.csv`

* `cleanup_organization_for_graphing_analysis.R` is for reorganizing, collating all the data from all the sources -- basically, getting the numbers ready for the publication. After this, the stats happen in the MS and the graphing in the figures.

* `foodweb.fn.R` is only a single function, `picture()`, which is good for making a picture of the foodweb

* `pd.functions.R` contains functions for analyzing the experiment, specifically the randomization tests.

* `phylogeny.R` reads in a newick tree (arbitrarily ultrametric, or taxonomy tree) and adds branchlengths from data downloaded from [TimeTree](timetree.org)

* `pred.div.R` applies the functions of `pd.functions.R` to the experimental data.  should probably be reworked and added to the main document.

* `predator.cooccurance.R` organizes co-occurrence data from the working group.  produces.  the probability of predators co-occuring as a function of their phylogenetic distance. 