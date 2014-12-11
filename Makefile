all: data/pd_exp_cleaned_data.csv data/predator_tree_time.newick data/reorganized.feeding.trial.data.csv data/predator.cooccur.metabolic.txt data/predator.cooccur.txt data/nodeages.csv data/phylogenetic_distance.csv data/proportion.eaten.csv data/randomization_summary.csv data/metabolic_occur_phylo.csv data/diet_overlap.csv

clean:

.PHONY: all clean

data/pd_exp_cleaned_data.csv: R.scripts/DATA_experimental_data_collate_cleanup.R raw-data/predator.div.experiment/*.csv raw-data/detritus/paperbags.csv raw-data/detritus/filters.csv
	cd $(<D); Rscript $(<F)

data/predator_tree_time.newick: R.scripts/DATA_phylogeny.R raw-data/TreeData/*
	cd $(<D); Rscript $(<F)

data/reorganized.feeding.trial.data.csv: R.scripts/DATA_foodweb_merge_cleanup.R raw-data/feeding.rearing/measured.predators.csv raw-data/feeding.rearing/other.predators.csv raw-data/Leptagrion/lept.csv
	cd $(<D); Rscript $(<F)

data/predator.cooccur.txt: R.scripts/DATA_predator.cooccurance.R raw-data/BWGdatasets/*
	cd $(<D); Rscript $(<F)

data/predator.cooccur.metabolic.txt: R.scripts/DATA_predator.cooccurance.R raw-data/BWGdatasets/*
	cd $(<D); Rscript $(<F)

data/nodeages.csv: R.scripts/DATA_nodeages.R raw-data/TreeData/*
	cd $(<D); Rscript $(<F)

data/phylogenetic_distance.csv: R.scripts/DATA_phylo_distance.R data/predator_tree_time.newick
	cd $(<D); Rscript $(<F)

data/proportion.eaten.csv: R.scripts/DATA_prop_eaten.R data/reorganized.feeding.trial.data.csv
	cd $(<D); Rscript $(<F)

data/randomization_summary.csv: R.scripts/DATA_summarize_randomization.R raw-data/predator.div.experiment/randomizations.group.means.csv
	cd $(<D); Rscript $(<F)

data/metabolic_occur_phylo.csv: R.scripts/CALC_meta_dist.R R.scripts/FUNCTIONS_predator_diversity.R data/predator.cooccur.metabolic.txt data/phylogenetic_distance.csv 
	cd $(<D); Rscript $(<F)

data/diet_overlap.csv: R.scripts/CALC_diet_dist.R data/proportion.eaten.csv R.scripts/FUNCTIONS_predator_diversity.R
	cd $(<D); Rscript $(<F)