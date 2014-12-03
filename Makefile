all: data/pd_exp_cleaned_data.csv data/predator_tree_time.newick

clean:

.PHONY: all clean

data/pd_exp_cleaned_data.csv: R.scripts/DATA_experimental_data_collate_cleanup.R raw-data/predator.div.experiment/*.csv raw-data/detritus/paperbags.csv raw-data/detritus/filters.csv
	cd $(<D); Rscript $(<F)

data/predator_tree_time.newick: R.scripts/DATA_phylogeny.R raw-data/TreeData/*
	cd $(<D); Rscript $(<F)