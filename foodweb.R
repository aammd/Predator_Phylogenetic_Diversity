##Graphing the Foodweb
## by Andrew MacDonald

measured <- read.csv("./feeding.rearing//measured.predators.csv",comment.char="#")
preds <- read.csv("./feeding.rearing//other.predators.csv")
preds <- preds[,-7]                              #drop comments
lepts <- read.csv("../Leptagrion/lept.csv")

source("foodweb.fn.R")
source("../general.R")

## make the lepts dataframe more managable
lepts <- with(lepts,
              data.frame(predator=Number,
                         predator.sp.lept=Sp.,body=Measuring..body.,
                         tail=Measuring..tail.))

measured.lept <- merge(measured,lepts,all.x=T)


# rename the awkward column

names(measured.lept)[which(names(measured.lept)=="Eaten.or.not..1...eaten")] <- "eaten"

#now combine the predator names from both datasets

names(measured.lept)

one <- with(measured.lept,as.character(predator.sp.))
two <- with(measured.lept,as.character(predator.sp.lept))

#one[which(one=="")] <- NA

new <- character(length=length(one))

new[which(one!="")] <- one[which(one!="")]
new[which(!is.na(two))] <- two[which(!is.na(two))]

new[which(new=="1 Leech "|new=="leech")] <- "Leech"

new[which(new=="elongatum"|new=="Leptagrion elongatum "|new=="leptagrion elongatum")] <- "Leptagrion elongatum"

new[which(new=="andromache")] <- "Leptagrion andromache"

new[which(new=="tan")] <- "Leptagrion 'tan'"

new[which(new=="small")] <- "Leptagrion small"

new[which(new=="green Tabanid"|new=="leech")] <- "Green Tabanid"

measured.lept$Predator <- as.factor(new)

#make an assumption about the fate of uneaten animals:
measured.lept$eaten[which(measured.lept$eaten!="0"&measured.lept$eaten!="1")]<- 0 
#in other words, if it didn't get eaten it doesn't count as eaten
measured.lept$eaten <- factor(measured.lept$eaten)
measured.lept$eaten <- as.numeric(measured.lept$eaten)-1  #lazy trick to convert to numbers

## and now for the Prey variable

prey.mes <- as.character(measured.lept$Prey)

prey.mes[which(prey.mes=="1 Tipulid "|prey.mes=="tipulid"|prey.mes=="1 Tipulid")] <- "Tipulid"

prey.mes[which(prey.mes=="1 polypedilum 2")] <- "1 Polypedilum 2"

prey.mes[which(prey.mes=="1 Scirtes A"|prey.mes=="scirtid A")] <- "Scirtes A"

prey.mes[which(prey.mes=="Leptagrion elongatum ")] <- "Leptagrion elongatum"

prey.mes[which(prey.mes=="1 Psychodid "|prey.mes=="1 psychodid ")] <- "Psychodid"

prey.mes[which(prey.mes=="1 Polypedilum 2")] <- "Polypedilum 2"

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
