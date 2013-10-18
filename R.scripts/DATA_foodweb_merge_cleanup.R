## Foodweb data reorganization
## by Andrew MacDonald
## based on foodweb data collected by Aline Nishi, Alathea Letaw, Robin Lecraw and Andrew MacDonald
## OUTPUT
##        ../data/reorganized_data/reorganized.feeding.trial.data.csv

# read in data, functions, packages ---------------------------------------

measured <- read.csv("/home/andrew/Dropbox/PhD/Brazil2011/data/feeding.rearing/measured.predators.csv",comment.char="#",as.is=TRUE)
preds <- read.csv("/home/andrew/Dropbox/PhD/Brazil2011/data/feeding.rearing/other.predators.csv",comment.char="#",as.is=TRUE)
lepts <- read.csv("/home/andrew/Dropbox/PhD/Brazil2011/data/Leptagrion/lept.csv",as.is=TRUE)


# tidy up variable names --------------------------------------------------

measured <- measured[,-which(names(measured)=="Comments")] #drop comments
preds <- preds[,-which(names(preds)=="Comments")]  #drop comments
## make the lepts dataframe more managable
lepts2 <- with(lepts,
              data.frame(predator=Number,
                         predator.sp.lept=Sp..,
                         body=Measuring..body.,
                         tail=Measuring..tail.,
                         stringsAsFactors=FALSE))

# rename the awkward column
names(measured)[which(names(measured)=="Eaten.or.not..1...eaten")] <- "eaten"


# merge dataframes --------------------------------------------------------

## keep all measured predators, but merge in the information from 'lepts'
measured.lept <- merge(measured,lepts2,all.x=TRUE)

#now combine the predator names from both datasets

is.nonzero.pred.species <- grepl("[a-z]+",measured.lept$predator.sp.)
## all the names
measured.lept$predator.sp.[is.nonzero.pred.species]
## no names!
measured.lept$predator.sp.[!is.nonzero.pred.species]

## take one vector, and fill in the blanks from the other
measured.lept$predator.names <- measured.lept$predator.sp.
measured.lept$predator.names[!is.nonzero.pred.species] <- measured.lept$predator.sp.lept[!is.nonzero.pred.species]

## we can compare all of these side-by-side
cbind(measured.lept$predator,measured.lept$predator.sp.,measured.lept$predator.sp.lept,measured.lept$predator.names)

## there are some missing values in predator.names
missing <- measured.lept$predator.names==""|is.na(measured.lept$predator.names)
measured.lept$predator.names[missing]

## what are their codes?
unique(measured.lept$predator[missing])
## [1] "197"  "198"  "208"  "L211" "L212" "L218" "L220" "L4"  
## if we make the assumption that 197, 198, 208 are leptagrion
## also that L211, L212, L218 L220 L4 are all leptagrion
## we can fill these in by brute force:

measured.lept[measured.lept$predator=="197","predator.names"] <- "andromache"
measured.lept[measured.lept$predator=="198","predator.names"] <- "andromache"
measured.lept[measured.lept$predator=="208","predator.names"] <- "andromache"
measured.lept[measured.lept$predator=="L211","predator.names"] <- NA
measured.lept[measured.lept$predator=="L212","predator.names"] <- NA
measured.lept[measured.lept$predator=="L218","predator.names"] <- NA
measured.lept[measured.lept$predator=="L220","predator.names"] <- NA
measured.lept[measured.lept$predator=="L4","predator.names"] <- "elongatum"



# combine duplicate predator names ------------------------------------------------

unique(measured.lept$predator.names)

measured.lept$predator.names[which(measured.lept$predator.names=="1 Leech "|
                                     measured.lept$predator.names=="leech")] <- "Hirudinidae"

measured.lept$predator.names[which(measured.lept$predator.names=="elongatum"|
                                     measured.lept$predator.names=="Leptagrion elongatum "|
                                     measured.lept$predator.names=="Leptagrion elongatum"|                                     
                                     measured.lept$predator.names=="leptagrion elongatum")] <- "Leptagrion.elongatum"

measured.lept$predator.names[which(measured.lept$predator.names=="andromache"|
                                     measured.lept$predator.names=="Leptagrion andromache")] <- "Leptagrion.andromache"

measured.lept$predator.names[which(measured.lept$predator.names=="tan")] <- "Leptagrion.tan"
measured.lept$predator.names[which(measured.lept$predator.names=="small")] <- "Leptagrion.small"

measured.lept$predator.names[which(measured.lept$predator.names=="green Tabanid"|
                                     measured.lept$predator.names=="tabanid"|
                                     measured.lept$predator.names=="Green Tabanid")] <- "Tabanidae.spA"

measured.lept$predator.names[which(measured.lept$predator.names=="red tabanid")] <- "Tabanidae.spB"

measured.lept$predator.names[which(measured.lept$predator.names=="white tabanid")] <- "Tabanidae.spC"


unique(measured.lept$predator.names)

#make an assumption about the fate of uneaten animals:
measured.lept$eaten[which(measured.lept$eaten!="0"&measured.lept$eaten!="1")]<- "0"
#in other words, if it didn't get eaten it doesn't count as eaten
measured.lept$eaten.numeric <- as.numeric(measured.lept$eaten=="1")

## and now for the Prey variable

prey.mes <- measured.lept$Prey

prey.mes[which(prey.mes=="1 Tipulid "|prey.mes=="tipulid"|prey.mes=="1 Tipulid")] <- "Tipulid"
prey.mes[which(prey.mes=="1 polypedilum 2")] <- "1 Polypedilum 2"
prey.mes[which(prey.mes=="1 Scirtes A"|prey.mes=="scirtid A")] <- "Scirtes A"
prey.mes[which(prey.mes=="Leptagrion elongatum ")] <- "Leptagrion.elongatum"
prey.mes[which(prey.mes=="Leptagrion elongatum")] <- "Leptagrion.elongatum"
prey.mes[which(prey.mes=="1 Psychodid "|prey.mes=="1 psychodid ")] <- "Psychodid"
prey.mes[which(prey.mes=="1 Polypedilum 2")] <- "Polypedilum 2"
prey.mes[which(prey.mes=="1 Monopelopia "|prey.mes=="1 Monopelopia")] <- "Monopelopia"
prey.mes[which(prey.mes=="1 Chironomus detriticula")] <- "Chironomus detriticula"
prey.mes[which(prey.mes=="1 Trichoptera")] <- "Phylloicus bromeliarum"
prey.mes[which(prey.mes=="1 Scirtes B")] <- "Scirtes B"
prey.mes[which(prey.mes=="1 Polypedilum 1")] <- "Polypedilum 1"
prey.mes[which(prey.mes=="1 Leech")] <- "Hirudinidae"
prey.mes[which(prey.mes=="1 Culex")] <- "Culex"
prey.mes[which(prey.mes=="ostracod"|prey.mes=="5 Ostracoda")] <- "Ostracod"

unique(prey.mes)

## compare with original factor
cbind(prey.mes,measured.lept$Prey)

## add to the dataframe
measured.lept$Prey.species <- factor(prey.mes)

## (not run) 
# ## confirm that is the same as phylogeny
# source("../R.scripts/phylogeny.R")
# ## how many taxa are in the tree?
# length(predtree$tip.label)
# ## what taxa are shared?
# sharedtaxa <- intersect(unique(measured.lept$predator.names),predtree$tip.label)
# ## what taxa *aren't* in the tree?
# unique(measured.lept$predator.names)[!unique(measured.lept$predator.names)%in%sharedtaxa]

### at this point, the "measured.lept" dataset contains all the data required for analysis.

write.csv(measured.lept,file="../data/reorganized_data/reorganized.feeding.trial.data.csv")