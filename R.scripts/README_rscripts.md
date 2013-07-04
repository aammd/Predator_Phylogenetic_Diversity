# R scripts for pd paper 

* `experimental_data_collate_cleanup.R` is for combining all the different datasets relevant to the **whole bromeliad experiment**, and cleaning them.  It produces `pd_exp_cleaned_data.csv` which contains *all* the data relevant to the experiment in 2011

* `foodweb_merge_cleanup.R` handles all the feeding trial data, and merges it with the leptagrion data.  the output is saved in `data/reorganized_data/reorganized.feeding.trial.data.csv`

* 