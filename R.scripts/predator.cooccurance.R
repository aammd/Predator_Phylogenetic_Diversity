## R code for calculating the co-occurance of predators

data <-
  read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/species/cardoso_2008_speciesname.txt",
             sep="\t",header=TRUE,stringsAsFactors=FALSE)

trait.data <-
  read.table("../../../CommunityAnalysis/Analyses/data.05dec2012/Distribution.organisms.csv",
             na.strings=c("NA","?"),header=TRUE,sep=",",stringsAsFactors=FALSE)

trait.data$Name
head(trait.data)
head(data)
data$name %in% 

data[[1]]

