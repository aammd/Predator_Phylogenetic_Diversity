## R code for organizing predator co-occurrence data
## this file reads in the relevant Bromeliad working group observational data
## and calculates co-occurance metrics for the predators.
## there are two calculations: one based on abundance, the other on metabolic capacity
##  OUTPUTS
##        ../data/predator.cooccur.metabolic.txt
##        ../data/predator.cooccur.txt


# load packages -----------------------------------------------------------

library(plyr)

# read in relevant BWG data -----------------------------------------------


data <-
  read.table("../raw-data/BWGdatasets/cardoso_2008_speciesname.txt",
             sep="\t",header=TRUE,stringsAsFactors=FALSE)

data_biomass <-
  read.table("../raw-data/BWGdatasets/Cardoso2008_WGformat_correct.txt",
             sep="\t",header=TRUE,stringsAsFactors=FALSE)

## remove this "comment" column:
data_biomass <- data_biomass[!names(data_biomass)%in%c("X")]

trait.data <- read.table("../raw-data/BWGdatasets/nicknames.FGs.csv",sep=",",
                         na.strings=c("NA","?"),header=TRUE,stringsAsFactors=FALSE)


# metabolic capacity calculation ------------------------------------------

## multiply the abundances (in all columns with a name that starts with "Brom") by the biomass:
biomass_animals <- data_biomass[grepl(pattern="Brom.",x=names(data_biomass))]*data_biomass$Biomass.avg.sp
## add back the species IDs (Taxa)
biomass_animals <- cbind(Taxa=data_biomass$Taxa,biomass_animals)
## finally, sum over Taxa

biomass_by_spp <- ddply(.data=biomass_animals,.variables=.(Taxa),colwise(sum,is.numeric))
## additionally, because I'm pretty sure we raise the biomass to the power first
metabolic_capacity <- function(x){
  sum(x^0.69)
}
metabolic_cap_spp <- ddply(.data=biomass_animals,.variables=.(Taxa),colwise(metabolic_capacity,is.numeric))


# renaming taxa -----------------------------------------------------------
## in this section I do lots of intense renaming so that all datasets use the same species names.

## how does metabolic_cap_spp compare to the abundance matrix?
#data[1:5,1:6]
#metabolic_cap_spp[1:5,1:6]
## close but not quite!  try this:
taxae <- gsub(pattern=" ",replacement=".",metabolic_cap_spp$Taxa)

## what are the shared spp? 
common.spp <- intersect(taxae,data$X) ## OK fine.  46 taxae are fine.

## what spp are not shared?
taxae[!taxae%in%common.spp]
data$X[!data$X%in%common.spp]

## make taxae identical to data$X
taxae[taxae=="Dasyhelea.sp."] <- "aff..Dasyhelea.sp."
taxae[taxae=="?Drosophilidae.sp..A"] <- "Drosophilidae.sp..A" 
taxae[taxae=="Leptagrion.elongatum.(C.and.D.-.the.same.species)"] <- "Leptagrion.elongatum"
taxae[taxae=="Leptagrion.macrurum.and.L..bocainense.(mix,.Zygoptera.sp.B,.tan)"] <- ".Leptagrion.macrurum.and.L..bocainense.(mix,.Zygoptera.sp.B,.tan)"
taxae[taxae=="Monopelopia.aff.caraguata"] <- "Monopelopia.aff..caraguata"
taxae[taxae=="Polypedium.sp.1"] <- "Polypedium.sp..1"
taxae[taxae=="Polypedium.sp.2"] <- "Polypedium.sp..2"
taxae[taxae=="Pseudochironomus"] <- "aff..Pseudochironomus.sp."
taxae[taxae=="Tabanid.spB.(green,.small-med)"] <- "Tabanid.sp.B"  

## now check again:
## what are the shared spp? 
common.spp <- intersect(taxae,data$X) ## OK fine.  46 taxae are fine.

## what spp are not shared?
taxae[!taxae%in%common.spp]
data$X[!data$X%in%common.spp]

## well, since none of these are predators, maybe it doesn't matter too much!  
## Let me make my life easier by cutting them out of metabolic_cap_spp
## remove the unwanted names from taxae
#taxae <- taxae[taxae%in%common.spp]
## obtain the nicknames ("names") from data
ID_lookup <- data.frame(Taxa=taxae,name=data$name[match(taxae,data[["X"]])],stringsAsFactors=FALSE)
## bind together 
spp_metabolic_nicknames <- cbind(ID_lookup,metabolic_cap_spp)

                        
taxae[taxae=="Dolichopodidae.spA"]
taxae[taxae=="Stenochironomus.subgenus.petalopholeus.(leaf.miner,.green.leaves.or.those.that.just.fallen)"]

# selecting predators - ABUNDANCE -----------------------------------------------------

## first get the cardoso taxa
func.group <- trait.data[["predator.prey"]][match(data[["name"]],trait.data[["nickname"]])]

## then attach to our data
data.fg <- cbind(func.group,data)

## finally, select only the predators:
predator.matrix <- data.fg[which(data.fg[["func.group"]]=="predator"),]
### note that several taxa are listed as NA, which is not a problem because they are either rare or 
### definitely not predators.

# combining morphospecies and cleaning data - ABUNDANCE -------------------------------

## delete the unused columns:
predator.matrix.sxs <- predator.matrix[,!names(predator.matrix)%in%c("func.group","name","realm")]
### (sxs because it is now a nice species x site matrix)

## combine corethrellids
## combine the corethrellids:
Corethr.spp <- grepl("Corethr*",predator.matrix.sxs[["X"]])
predator.matrix.sxs[["X"]][Corethr.spp] <- "Corethrella.sp"

## the "=" causes grief:

predator.matrix.sxs[["X"]] <- gsub(pattern="=",replacement="",x=predator.matrix.sxs[["X"]])

## using plyr, combine Corethrellids:

predator.mat <- ddply(.data=predator.matrix.sxs,
                      .variables=.(X),.fun=colwise(sum))

## renaming, using names from phylogeny, for proper merging in `cleanup.R`
## here is a vector of the tip labels from the phylogeny.  They're ordered to match the rows of predator.mat
rename.rows <- c("Bezzia.sp1", "Bezzia.sp2", "Corethrella", "Dolichopodidae", 
                 "Empididae.sp1", "Empididae.sp2", "Hirudinidae", "Leptagrion.andromache", 
                 "Leptagrion.elongatum", "Leptagrion.tan", "Monopelopia", "Tabanidae.spA", 
                 "Tabanidae.spB", "Tabanidae.spC")
## this line (not run) shows that they do, in fact, match.
## cbind(rename.rows,predator.mat[["X"]])
predator.mat[["X"]] <- rename.rows

## write to a file in /data/reorganized_data
write.csv(x=predator.mat,file="../data/predator.cooccur.txt",row.names=FALSE)



# selecting predators - METABOLIC -----------------------------------------------------

## first get the cardoso taxa
func.group_meta <- trait.data[["predator.prey"]][match(spp_metabolic_nicknames[["name"]],trait.data[["nickname"]])]

## then attach to our data
data.fg_meta <- cbind(func.group_meta,spp_metabolic_nicknames)

## finally, select only the predators:
predator.matrix_meta <- data.fg_meta[which(data.fg_meta[["func.group_meta"]]=="predator"),]
### note that several taxa are listed as NA, which is not a problem because they are either rare or 
### definitely not predators.

# combining morphospecies and cleaning data - METABOLIC -------------------------------

## delete the unused columns:
predator.matrix.sxs_meta <- predator.matrix_meta[,!names(predator.matrix_meta)%in%c("func.group","name","realm")]
### (sxs because it is now a nice species x site matrix)

## combine corethrellids
## combine the corethrellids:
Corethr.spp_meta <- grepl("Corethr*",predator.matrix.sxs_meta[["Taxa"]])
predator.matrix.sxs_meta[["Taxa"]][Corethr.spp_meta] <- "Corethrella.sp"

## the "=" causes grief:

predator.matrix.sxs_meta[["Taxa"]] <- gsub(pattern="=",replacement="",x=predator.matrix.sxs_meta[["Taxa"]])

## using plyr, combine Corethrellids:

predator.mat_meta <- ddply(.data=predator.matrix.sxs_meta,
                      .variables=.(Taxa),.fun=numcolwise(sum))

## renaming, using names from phylogeny, for proper merging in `cleanup.R`
## here is a vector of the tip labels from the phylogeny.  They're ordered to match the rows of predator.mat
rename.rows <- c("Bezzia.sp1", "Bezzia.sp2", "Corethrella", "Dolichopodidae", 
                 "Empididae.sp1", "Empididae.sp2", "Hirudinidae", "Leptagrion.andromache", 
                 "Leptagrion.elongatum", "Leptagrion.tan", "Monopelopia", "Tabanidae.spC", 
                 "Tabanidae.spA", "Tabanidae.spB")
## this line (not run) shows that they do, in fact, match.
#cbind(rename.rows,predator.mat_meta[["Taxa"]])

predator.mat_meta[["Taxa"]] <- rename.rows


## write to a file in /data/reorganized_data
write.csv(x=predator.mat_meta,file="../data/predator.cooccur.metabolic.txt",row.names=FALSE)