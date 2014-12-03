all: data/pd_exp_cleaned_data.csv data/predator_tree_time.newick data/reorganized.feeding.trial.data.csv

clean:

.PHONY: all clean

data/pd_exp_cleaned_data.csv: R.scripts/DATA_experimental_data_collate_cleanup.R raw-data/predator.div.experiment/*.csv raw-data/detritus/paperbags.csv raw-data/detritus/filters.csv
	cd $(<D); Rscript $(<F)

data/predator_tree_time.newick: R.scripts/DATA_phylogeny.R raw-data/TreeData/*
	cd $(<D); Rscript $(<F)

data/reorganized.feeding.trial.data.csv: R.scripts/DATA_foodweb_merge_cleanup.R raw-data/feeding.rearing/measured.predators.csv raw-data/feeding.rearing/other.predators.csv raw-data/Leptagrion/lept.csv
	cd $(<D); Rscript $(<F)