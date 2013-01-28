##Graphing the Foodweb
## by Andrew MacDonald

# I guess we start by setting WD to be here?  Needless if you start from emacs
setwd("/home/andrew/Dropbox/PhD/Brazil2011/R.scripts/")

# read in data, functions, packages ---------------------------------------

measured <- read.csv("../feeding.rearing/measured.predators.csv",comment.char="#",as.is=TRUE)
preds <- read.csv("../feeding.rearing/other.predators.csv",comment.char="#",as.is=TRUE)
lepts <- read.csv("../Leptagrion/lept.csv",as.is=TRUE)

source("foodweb.fn.R")
source("general.R")

library(ggplot2)

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

## Next eliminate duplicate names
unique(measured.lept$predator.names)

measured.lept$predator.names[which(measured.lept$predator.names=="1 Leech "|measured.lept$predator.names=="leech")] <- "Leech"

measured.lept$predator.names[which(measured.lept$predator.names=="elongatum"|measured.lept$predator.names=="Leptagrion elongatum "|measured.lept$predator.names=="leptagrion elongatum")] <- "Leptagrion elongatum"

measured.lept$predator.names[which(measured.lept$predator.names=="andromache")] <- "Leptagrion andromache"

measured.lept$predator.names[which(measured.lept$predator.names=="tan")] <- "Leptagrion 'tan'"

measured.lept$predator.names[which(measured.lept$predator.names=="small")] <- "Leptagrion small"

measured.lept$predator.names[which(measured.lept$predator.names=="green Tabanid"|measured.lept$predator.names=="tabanid")] <- "Green Tabanid"

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

prey.mes[which(prey.mes=="Leptagrion elongatum ")] <- "Leptagrion elongatum"

prey.mes[which(prey.mes=="1 Psychodid "|prey.mes=="1 psychodid ")] <- "Psychodid"

prey.mes[which(prey.mes=="1 Polypedilum 2")] <- "Polypedilum 2"

prey.mes[which(prey.mes=="1 Monopelopia "|prey.mes=="1 Monopelopia")] <- "Monopelopia"

unique(prey.mes)
measured.lept$Prey <- factor(prey.mes)

## predators in this dataset
with(measured,table(sp))

## we seem to be missing species names for 211, 212, 218 and 220

## add these

## ignorning for the moment about the size, add these together within
## predatorxprey combo

## then combine with unmeasured predators

## position two columns - a predator and a prey - and draw lines between them.

## lets just try something simple

## for the purpose of plotting, consider the following simplifications:

pred.char <- as.character(preds$Predator)
pred.char[which(preds$Predator=="1 Leech "|preds$Predator=="leech")] <- "Leech"
preds$Predator <- factor(pred.char)


prey.char <- as.character(preds$Prey)
prey.char[which(preds$Prey=="tricoptera"|preds$Prey=="1 Trichoptera")] <- "Trichoptera"
prey.char[which(preds$Prey=="culex"|preds$Prey=="1 Culex")] <- "Culex"
preds$Prey <- factor(prey.char)

preds$eaten <- preds[,"N..trials.with.eaten.prey"]/preds[,"N..trials"]

picture(preds)


  ## editing the measured.lept dataset

### count the number of trials of each pair and sum successes
 
from.measured <- with(measured.lept,aggregate(eaten,
                                              by=list(Predator=Predator,Prey=Prey),
                                              FUN=function(x) sum(x)/length(x)
                                              )
                      )

names(from.measured)[which(names(from.measured)=="x")] <- "eaten"

picture(from.measured)

#now we have two separate ones - but I want to put them together!!

Predator <- c(as.character(preds$Predator),
              as.character(from.measured$Predator))

Predator[which(Predator=="tabanid"|Predator=="1 Tabanid")] <- "Tabanid"

Prey <- c(as.character(preds$Prey),
          as.character(from.measured$Prey))

Prey[which(Prey=="1 Monopelopia ")] <- "1 Monopelopia"

Prey[which(Prey=="1 Tipulid")] <- "Tipulid"

Prey[which(Prey=="scirtes B"|Prey=="1 Scirtes B")] <- "Scirtes B"

Prey[which(Prey=="scirtes A")] <- "Scirtes A"

Prey[which(Prey=="ostracod"|Prey=="5 Ostracoda")] <- "Ostracod"

Prey[which(Prey=="1 Culex")] <- "Culex"

Prey[which(Prey=="1 Leech"|Prey=="leech")] <- "Leech"

Prey[which(Prey=="1 Trichoptera")] <- "Trichoptera"

Prey[which(Prey=="1 psychodid")] <- "Psychodid"

eaten <- c(preds$eaten,from.measured$eaten)

feeding <- data.frame(Predator,Prey,eaten)
feeding <- subset(feeding,feeding$Predator!="")
feeding$Predator <- factor(feeding$Predator)          #removes unwanted factor levels


pngPPT("Cardoso food web.png")
picture(feeding)
dev.off()

feeding$lept <- factor(c("not","lept")[(as.numeric(feeding$Predator==levels(feeding$Predator)[6]|
                                                   feeding$Predator==levels(feeding$Predator)[7]|
                                                   feeding$Predator==levels(feeding$Predator)[8]|
                                                   feeding$Predator==levels(feeding$Predator)[9])
                                        +1)
                                       ]
                       )

test <- subset(feeding,feeding$lept=="not")
test$Predator <- factor(test$Predator)
test$Prey <- factor(test$Prey)

pngPPT("non.lept.png")
picture(test,spread=2)
dev.off()

test1 <- subset(feeding,feeding$lept=="lept")
test1$Predator <- factor(test1$Predator)
test1$Prey <- factor(test1$Prey)

pngPPT("lept.png")
picture(test1,spread=3)
dev.off()
