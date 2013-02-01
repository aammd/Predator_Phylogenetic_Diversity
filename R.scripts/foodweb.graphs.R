## analysis and graphing of the food web data 

# read in functions and packages ------------------------------------------

source("foodweb.fn.R")
source("general.R")

library(ggplot2)
library(bipartite)
library(reshape)

# read in data ------------------------------------------------------------

foodweb <- read.csv("../feeding.rearing/reorganized.feeding.trial.data.csv")


# graph data --------------------------------------------------------------

## try the bipartite approach:
## data needs to be in a matrix

head(foodweb)

## need predators as columns, herbivores as rows
foodweb.cast <- cast(data=foodweb,formula=Prey.species~predator.names,value="eaten.numeric",fun.aggregate=sum)

foodweb.matrix <- as.matrix(foodweb.cast[,-1])
dimnames(foodweb.matrix) <- list(foodweb.cast[[1]],names(foodweb.cast)[-1])
foodweb.matrix

visweb(foodweb.matrix)
plotweb(foodweb.matrix)

## the PROBLEM is that there are 0s and there are NAs and I want to have a means
## of displaying each


# not yet reorganized!  clean it up ---------------------------------------


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
