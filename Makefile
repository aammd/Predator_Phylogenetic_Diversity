all:  MS/predatordiversity.pdf

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

data/summarize_randoms_phylo.csv: R.scripts/DATA_summarize_randomization.R raw-data/predator.div.experiment/randomizations.group.means.csv data/phylogenetic_distance.csv
	cd $(<D); Rscript $(<F)

data/metabolic_occur_phylo.csv: R.scripts/CALC_meta_dist.R R.scripts/FUNCTIONS_predator_diversity.R data/predator.cooccur.metabolic.txt data/phylogenetic_distance.csv 
	cd $(<D); Rscript $(<F)

data/diet_overlap_phylo.csv: R.scripts/CALC_diet_dist.R R.scripts/FUNCTIONS_predator_diversity.R data/proportion.eaten.csv data/phylogenetic_distance.csv
	cd $(<D); Rscript $(<F)

data/distributional_similarity_AIC.csv: R.scripts/CALC_dist_aic.R R.scripts/FUNCTIONS_predator_diversity.R data/metabolic_occur_phylo.csv
	cd $(<D); Rscript $(<F)

data/diet_similarity_AIC.csv: R.scripts/CALC_diet_aic.R R.scripts/FUNCTIONS_predator_diversity.R data/diet_overlap_phylo.csv
	cd $(<D); Rscript $(<F)

diet_predictions.csv: R.scripts/CALC_diet_nlsconfint.R data/diet_overlap_phylo.csv
	cd $(<D); Rscript $(<F)

Figures/FIG_1.pdf: R.scripts/FIG1.R data/metabolic_occur_phylo.csv data/diet_overlap_phylo.csv data/pd_exp_cleaned_data.csv data/phylogenetic_distance.csv data/diet_predictions.csv
	cd $(<D); Rscript $(<F)

Figures/FIG_2.pdf: R.scripts/FIG2.R data/pd_exp_cleaned_data.csv
	cd $(<D); Rscript $(<F)

Figures/FIG_3.pdf: R.scripts/FIG3.R data/summarize_randoms_phylo.csv
	cd $(<D); Rscript $(<F)

data/modlist.RData: R.scripts/CALC_pd_experiment_models.R data/phylogenetic_distance.csv data/pd_exp_cleaned_data.csv
	cd $(<D); Rscript $(<F)

MS/predatordiversity.pdf: MS/predatordiversity.Rmd data/predator.cooccur.txt data/predator.cooccur.metabolic.txt data/metabolic_occur_phylo.csv data/reorganized.feeding.trial.data.csv data/diet_overlap_phylo.csv data/nodeages.csv data/pd_exp_cleaned_data.csv data/modlist.RData R.scripts/FUNCTIONS_predator_diversity.R R.scripts/FUNCTIONS_text.R
	cd $(<D); Rscript -e 'rmarkdown::render("$(<F)")'