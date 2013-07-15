## PD-EF experiment data is stored in several smaller datasets.  
## This file reads them all together, merges them, prepares them for analysis
## Andrew MacDonald, 2013


# read in the datasets ----------------------------------------------------

lvs<-read.csv("~/Dropbox/PhD/Brazil2011/data/predator.div.experiment/leaves.csv")
coarse<-read.csv("~/Dropbox/PhD/Brazil2011/data/detritus/paperbags.csv")
fine <- read.csv("~/Dropbox/PhD/Brazil2011/data/detritus/filters.csv")
pd<-read.csv("~/Dropbox/PhD/Brazil2011/data/predator.div.experiment/cages.csv")
n15<-read.csv("~/Dropbox/PhD/Brazil2011/data/predator.div.experiment/n15.csv")
emerg<-read.csv("~/Dropbox/PhD/Brazil2011/data/predator.div.experiment/emerg.csv")
surv <- read.csv("~/Dropbox/PhD/Brazil2011/data/predator.div.experiment/survived.csv",comment.char="#")
samp <- read.table("~/Dropbox/PhD/Brazil2011/data/predator.div.experiment/Samples.csv",comment.char="#",sep=",",flush=TRUE,header=TRUE)

## correctly order the treatment factor
pd$treatment<-factor(pd$treatment,
	levels=c('control','andro','elong','tabanid','leech',
	'elong + andro','elong + tab','elong + leech')
	)


# GROWTH ------------------------------------------------------------------

## Calculate the growth of each bromeliad
lvs$growth<-with(lvs,final.length-length)

## average all the leaves per bromeliad
## this is the only variable which requires to be AVERAGED before being combined.
growth<-with(lvs,tapply(growth,bromeliad,mean,na.rm=TRUE)) # is a vector
## make vector a dataframe:
growth<-data.frame(bromeliad=names(growth),growth=growth)

## combine with the data on treatment!
pd<-merge(growth,pd)
## remove growth dataframe
rm(growth)


# COARSE DETRITUS ---------------------------------------------------------

## find detritus mass by subtracting the full and empty mass of the bags:
coarse$leaf.mass<-with(coarse,full-empty)

## how many are less than zero?
##coarse$leaf[!is.na(coarse$leaf.mass)&coarse$leaf.mass<0,]
## these should probably be considered as zero  
## anyway they're all e , meaning they are extra (ie not our leaves)

## c is material that is only coarse, so only this stuff should be subtracted from what was put in.
final.leaf.mass<-with(subset(coarse,experiment=="pred.div"&coarse.or.extra=="c"),
                      tapply(leaf.mass,eu,sum,na.rm=T))

## combining the final mass data with the full dataset (pd)!
leaf.mass<-data.frame(eu=names(final.leaf.mass),leaf.mass=final.leaf.mass)
pd<-merge(leaf.mass,pd)
## remove intermediate datasets.
rm(leaf.mass)
rm(final.leaf.mass)

## combining original mass of leaves with the full dataset (pd)
pd<-merge(pd,n15)

## calculating percent decomposition
pd$decomp<-with(pd,(mass.g.-leaf.mass)/mass.g.)


# FINE DETRITUS -----------------------------------------------------------

fine$fine.mass<-with(fine,full-empty)

fine.mass<-with(subset(fine,experiment=="pred.div"),
                tapply(fine.mass,eu,sum,na.rm=T))
#cleans it a bit
fine.mass <- fine.mass[!is.na(fine.mass)]

## combining the final mass data with the full dataset (pd)!
fine.mass<-data.frame(eu=names(fine.mass),fine=fine.mass)
pd<-merge(fine.mass,pd)
rm(fine.mass)


# EMERGENCE ---------------------------------------------------------------


emerged<-with(emerg,tapply(number,eu,sum))
emerged<-data.frame(eu=names(emerged),emerged=emerged)
pd<-merge(emerged,pd,all=TRUE)

# calculate how many emerged of each species group
emerg.by.sp <- with(emerg,tapply(number,list(eu,species),sum,na.rm=TRUE))
emerg.by.sp[is.na(emerg.by.sp)] <- 0
emerg.by.sp <- data.frame(eu=rownames(emerg.by.sp),emerg.by.sp)

## necessary to fill in NAs since they actually represent no emergence
## and therefore true zeros.
pd$emerged[is.na(pd$emerged)] <- 0
#with(pd,plot(emerged~treatment))
rm(emerged)
## note that some of this will be used later:

# SURVIVAL (combines w emergence) ----------------------------------------

#add in survived ones
## subtracting oligochaetes, identified chironomids (because they are often underestimates) and the eu column
insect.species.used.in.survival <- c("chiromids","Psychodid",
                                     "Scirtes.sp.A","Culex","Tipulid")



##surv.total<-data.frame(eu=surv$eu,
##                       surv=rowSums(surv[,insect.species.used.in.survival]))

surv.by.sp <- data.frame(eu=surv$eu,
                       surv[,insect.species.used.in.survival])


##pd <- merge(surv.total,pd)
#with(pd,plot(surv~treatment))
##pd$total.surv <- pd$surv+pd$emerged
##rm(surv.total)

## Calculate the totals of each species which survived
head(emerg.by.sp)
head(surv.by.sp)
all.surv <- merge(surv.by.sp,emerg.by.sp,by.x="eu",by.y="eu",all.x=TRUE) #weirdly
                                        #this doesn't work the other
                                        #way around
survival <- data.frame(
              eu=all.surv[,"eu"],
              Culicidae=rowSums(all.surv[,c("Culex","culicid")],na.rm=TRUE),
              Chironomidae=rowSums(all.surv[,c("chiromids","midge")],na.rm=TRUE),
              Tipulidae=rowSums(all.surv[,c("Tipulid","tipulid")],na.rm=TRUE),
              Psychodidae=rowSums(all.surv[,c("Psychodid","psychodid")],na.rm=TRUE),
              Scirtidae=rowSums(all.surv[,c("Scirtes.sp.A","scirtes")],na.rm=TRUE)
              )

which(survival[,"Culicidae"]>4) #none
which(survival[,"Chironomidae"]>16) #none
excess.P <- which(survival[,"Psychodidae"]>1) #8 !!
excess.S <- which(survival[,"Scirtidae"]>5) #7 !!
excess.T <- which(survival[,"Tipulidae"]>1) #5 !!

## set all survivorship of those groups which *increased* (which should be impossible!) to 100%
survival[excess.P,"Psychodidae"] <- 1
survival[excess.S,"Scirtidae"] <- 5
survival[excess.T,"Tipulidae"] <- 1

survival$total.surv <- rowSums(survival[,-1])

pd <- merge(pd,survival)

rm(list=c("all.surv","emerg.by.sp","survival","surv.by.sp",
          "excess.P","excess.S","excess.T","insect.species.used.in.survival"))

# DUMMY VARIABLES ---------------------------------------------------------


pd$leech <- as.numeric(pd$treatment=="leech"|pd$treatment=="elong + leech")
pd$andro <- as.numeric(pd$treatment=="andro"|pd$treatment=="elong + andro")
pd$tab <- as.numeric(pd$treatment=="tabanid"|pd$treatment=="elong + tab")
pd$elong <- as.numeric(pd$treatment=="elong"|
                       pd$treatment=="elong + leech"|
                       pd$treatment=="elong + andro"|
                       pd$treatment=="elong + tab")


# N15 samples -------------------------------------------------------------

## Samples 1A and 2A are the enriched leaves. remove em.
enriched <- droplevels(samp[samp$Id==c("1A","2A"),])
samp <- droplevels(samp[samp$Id!=c("1A","2A"),])

## make 'eu', for combining with pd
samp$eu <- as.numeric(sub("EU","",samp$Id))

pd <- merge(samp,pd)

rm(lvs,coarse,fine,n15,emerg,surv,samp)

#### write data out ####
## experimental data
write.csv(pd,file="~/Dropbox/PhD/Brazil2011/data/reorganized_data/pd_exp_cleaned_data.csv",
  row.names=FALSE)
## enriched leaves
write.csv(enriched,file="~/Dropbox/PhD/Brazil2011/data/reorganized_data/enriched_leaves.csv",
          row.names=FALSE)

