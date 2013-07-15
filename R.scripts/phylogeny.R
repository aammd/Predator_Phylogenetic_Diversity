library(picante)

## read in the "arbitrairly ultrametric" tree which I stuck together in Mesquite, which represents the taxonomic relationships of these predators
predtree <- read.tree("../data/TreeData/predators.arbit.ultrametric.phy")

## read in all data 
insects_to_leeches <- mean(read.csv("../data/TreeData//insects.to.leeches.csv")$Time)
odonata_tabanid <- mean(read.csv("../data/TreeData/odonata-Tabanidae.csv")$Time)
cerato_chiro <- mean(read.csv("../data/TreeData/Ceratopogonidae_Chironomidae.csv")$Time)
culicidae_chironomidae <- mean(read.csv("../data/TreeData/CulicidaetoChironomidae.csv")$Time)
empid_dolicho <- mean(read.csv("../data/TreeData/empididaeDolichopodidae.csv")$Time)
dolicho_tabanid <- mean(read.csv("../data/TreeData/dolicho_tabanid.csv")$Time)
diptera <- mean(read.csv("../data/TreeData/tabanidae_culidicae_ie_Diptera.csv")$Time)

## now a phylogenetic tree for all predators in the experiment
## create a new tree to modify with branchlenghts:
predtree_timetree_ages <- predtree
## we can alter the edge lengths one at a time
## first the trouble of knowing what edge to modify.
## use tip.label and node.label
## change 15 years for all leptagrion
change_edgelength <- function(desc_name_regex,ancest_name_regex,age,tree=predtree_timetree_ages){
  tip_and_node <- c(tree$tip.label,tree$node.label)
  location_ancestor <- which(grepl(ancest_name_regex,tip_and_node))
  location_descendent <- which(grepl(desc_name_regex,tip_and_node))
  edges <- which(tree$edge[,1]%in%location_ancestor&tree$edge[,2]%in%location_descendent)
  tree$edge.length[edges] <- age
  tree
}
## set the age of Leptagrion to the age of enallagama
predtree_timetree_ages <- change_edgelength(desc_name_regex="Lept.",ancest_name_regex="Leptagrion",age=15,tree=predtree_timetree_ages)
## subtract this distance from the age of the common ancestor of all pterygota::
predtree_timetree_ages <- change_edgelength(desc_name_regex="Leptagrion",ancest_name_regex="Pterygota",age=odonata_tabanid-15,tree=predtree_timetree_ages)
## bezzia -- for now give it 15 as well
predtree_timetree_ages <- change_edgelength(desc_name_regex="Bezzia.",ancest_name_regex="Bezzia",age=15,tree=predtree_timetree_ages)
## bezzia to monopelopia -- ceratopogonid to chironomid
predtree_timetree_ages <- change_edgelength(desc_name_regex="Monopelopia",ancest_name_regex="Chironomoidea",age=cerato_chiro,tree=predtree_timetree_ages)
## same for Bezzia
predtree_timetree_ages <- change_edgelength(desc_name_regex="Bezzia",ancest_name_regex="Chironomoidea",age=cerato_chiro-15,tree=predtree_timetree_ages)
# Corethrella is descended from the Culicimorpha, as are Bezzia & monopelopia
predtree_timetree_ages <- change_edgelength(desc_name_regex="Corethrella",ancest_name_regex="Culicimorpha",age=culicidae_chironomidae,tree=predtree_timetree_ages)
# just need the branch from Chironomoidea to the ancestor Culicimorpha
predtree_timetree_ages <- change_edgelength(desc_name_regex="Chironomoidea",ancest_name_regex="Culicimorpha",age=culicidae_chironomidae-cerato_chiro,tree=predtree_timetree_ages)
# let's just say Empididae also is 15 million
predtree_timetree_ages <- change_edgelength(desc_name_regex="Empididae.",ancest_name_regex="Empididae",age=15,tree=predtree_timetree_ages)
## time tree for difference between empididae and dolicho:
predtree_timetree_ages <- change_edgelength(desc_name_regex="Dolichopodidae",ancest_name_regex="Empidoidea",age=empid_dolicho,tree=predtree_timetree_ages)
predtree_timetree_ages <- change_edgelength(desc_name_regex="Empididae",ancest_name_regex="Empidoidea",age=empid_dolicho-15,tree=predtree_timetree_ages)
## dolichopodidae to tabanidae.  is an internal node, so requires some subtraction:
## again, set Tabanids to 15?
predtree_timetree_ages <- change_edgelength(desc_name_regex="Tabanidae.",ancest_name_regex="Tabanidae",age=20,tree=predtree_timetree_ages)
## here common ancestor is Brachycera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Tabanidae",ancest_name_regex="Brachycera",age=dolicho_tabanid-20,tree=predtree_timetree_ages)
## and the difference to common ancestor of dolich&Empidiae to Brachycera:
predtree_timetree_ages <- change_edgelength(desc_name_regex="Empidoidea",ancest_name_regex="Brachycera",age=dolicho_tabanid-empid_dolicho,tree=predtree_timetree_ages)
## Brachycera Diptera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Brachycera",ancest_name_regex="Diptera",age=diptera-dolicho_tabanid,tree=predtree_timetree_ages)
# culicimorpha to diptera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Culicimorpha",ancest_name_regex="Diptera",age=diptera-culicidae_chironomidae,tree=predtree_timetree_ages)
# now add the age of pterygota to diptera
predtree_timetree_ages <- change_edgelength(desc_name_regex="Diptera",ancest_name_regex="Pterygota",age=odonata_tabanid-diptera,tree=predtree_timetree_ages)
# finally, the leeches:
predtree_timetree_ages <- change_edgelength(desc_name_regex="Pterygota",ancest_name_regex="Protostomia",age=insects_to_leeches-odonata_tabanid,tree=predtree_timetree_ages)
## LEECHES themselves are simple
predtree_timetree_ages <- change_edgelength(desc_name_regex="Hirudinidae",ancest_name_regex="Protostomia",age=insects_to_leeches,tree=predtree_timetree_ages)

## kill all the node ages, leaving only the predtree and predtree_timetree_ages
rm(list=c("cerato_chiro","change_edgelength","culicidae_chironomidae","diptera","dolicho_tabanid","empid_dolicho","insects_to_leeches","odonata_tabanid"))