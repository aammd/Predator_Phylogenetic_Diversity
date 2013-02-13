## dataset for analysis of pred diversity experiment data

## read in functions
source('pd.functions.R')
### organization
source("data.pd.R")
## libraries
library(gplots)
library(lattice)
library(ggplot2)
## housekeeping
#dropping a record that seems to have been 90% decomposed!
pd[which(pd$decomp>0.7),'decomp'] <- NA



## just to make sure:
with(pd,table(treatment))
head(pd)
######################3
#graphing and exploring


##with(pd,plot(total.surv~treatment))

###with(pd,lm(total.surv~treatment))

#pdf()
#par(cex=0.6)
#with(pd,plot(total.surv~treatment,main="survival"))
#with(pd,plot(fine~treatment,main="fine detritus production (g)"))
#with(pd[-which(pd$decomp>0.8),],plot(decomp~treatment,main="% decomposition"))
#with(pd,plot(growth~treatment,main="mean growth per plant (cm)"))
#dev.off()

#barplot(with(lvs,tapply(growth,bromeliad,mean,na.rm=T)))

## fine production seems to differ among treatment
#with(pd,plot(fine~treatment))

## there is no relationship between fine production and coarse decomp 
#with(pd,plot(fine~decomp))


#with(pd,plot(growth~treatment))


#full.model <- with(pd,glm(surv~leech*andro*tab*elong,family=poisson))

#full.model <- with(pd,glm(surv~leech/elong*andro*tab*elong,family=poisson))

#with(pd,interaction.plot(leech,elong,surv))

#with(pd,lm(growth~treatment))



#####################################################################################
#####################################################################################
#                NONADDITIVE EFFECT of predator combinations


##---------------------------------------------------------------------------
##-----this section of the analysis is on INDIVIDUALS not GROUP MEANS
##---------------------------------------------------------------------------
#go <- responses(500)
#write.csv(go,"../predator.div.experiment/randomizations.one.at.a.time.csv")
rand.indiv <- read.csv("../predator.div.experiment/randomizations.one.at.a.time.csv")
rand.indiv$sp.pair <- factor(rand.indiv$sp.pair,
                             levels=c('elong + andro','elong + tab',
                               'elong + leech')
                             )


pdf("../figures/randomization.indiv.pdf")
densityplot(~growth,groups=sp.pair,data=rand.indiv,auto.key=T)
densityplot(~survival,groups=sp.pair,data=rand.indiv,auto.key=T)
densityplot(~fine,groups=sp.pair,data=rand.indiv,auto.key=T)
densityplot(~decomp,groups=sp.pair,data=rand.indiv,auto.key=T)
dev.off()

### no longer works for individual-based data :()
# pdf('../figures/confidence.intervals.indiv.means.pdf')
# par(mfrow=c(2,2),bty='l')
# for(i in 2:6) ci.resp(i,sim.data=rand.indiv,
#                       Ylab="monoculture-polyculture (single reps)")
# dev.off()

##--------------------------------------------------------------------------

##---------------------------------------------------------------------------
##-----this section of the analysis is on GROUP MEANS not INDIVIDUALS
##---------------------------------------------------------------------------
##go2 <- responses.means(1000)
#write.csv(go2,"randomizations.group.means.csv")
rand.means <- read.csv("../predator.div.experiment/randomizations.group.means.csv")
rand.means$sp.pair <- factor(rand.means$sp.pair,
                             levels=c('elong + andro','elong + tab',
                               'elong + leech')
                             )


##---------------------------------------------------------------------------
##-----graphing of the results of these randomizations 
##---------------------------------------------------------------------------


#one <- densityplot(~survival|sp.pair,data=go)
#two <- densityplot(~growth|sp.pair,data=go)

#print(one,position=c(0,0.5,1,1),more=T)
#print(two,position=c(0,0,1,0.5),more=T)


#densityplot(~growth+survival+fine+decomp,groups=sp.pair,data=go)

pdf("../figures/randomization.mean.pdf")
densityplot(~growth,groups=sp.pair,data=rand.means,auto.key=T)
densityplot(~survival,groups=sp.pair,data=rand.means,auto.key=T)
densityplot(~fine,groups=sp.pair,data=rand.means,auto.key=T)
densityplot(~decomp,groups=sp.pair,data=rand.means,auto.key=T)
densityplot(~N,groups=sp.pair,data=rand.means,auto.key=T)
dev.off()

pdf('../figures/confidence.intervals.group.means.pdf')
par(mfrow=c(2,3),bty='l')
for(i in 2:6) ci.resp(i)
dev.off()



##-----misc. statistics for the comparisons of non-additive predator effects
##---------------------------------------------------------------------------


## a t-test for the difference between means.

with(pd,t.test(total.surv[treatment=="elong + leech"],
               total.surv[treatment=="elong"|
                          treatment=="leech"])
     )



#go2 <- responses.means(1000)

## a quick look at randomization results with a histogram
lapply(go2[,-6],hist)

##---------------------------------------------------------------------------
##--------decomposition/survival graphs
##---------------------------------------------------------------------------

#### how does decomposition change with survival of insects
with(pd,plot(decomp~total.surv))
xyplot(decomp~total.surv|treatment,data=pd)
xyplot(decomp~total.surv,groups=treatment,data=pd)

qplot(decomp,total.surv,facets=treatment~.,data=pd)
  

##png("polys.png",width=279,height=150,units="mm",res=100)
svg("../figures/polys.svg",height=3.5)
pred.graph()
dev.off()

## a plot of the nitrogen data

xyplot(d15N~treatment,data=pd)

svg("../figures/n.trt.svg",height=3.5)
par(bty="l")
x <- with(pd,plotmeans(d15N~treatment,n.label=FALSE,barcol="black",pch=21,col="gray",connect=FALSE,ylab=expression(delta)))
x <-
  with(pd,barplot(tapply(d15N,treatment,mean),ylab=expression(delta*N^15),col="white",border="white",ylim=c(-5,20)))
box(bty="l")
pts <- with(pd,tapply(d15N,treatment,mean))
se <- with(pd,tapply(d15N,treatment,sd))/sqrt(5)
segments(x,y0=pts-se,y1=pts+se)
with(pd,points(x,pts,pch=21,bg="darkgrey"))
dev.off()


plot(with(pd,lm(X15N~treatment)))


par(mfrow=c(2,3),bty='l')
for(i in 2:6) ci.resp(i)

svg("../figures/n.effect.svg",height=10,width=10)
par(cex=2.5,bty="l",lwd=3)
ci.resp(6,Ylab="additive effect on N")
dev.off()

densityplot(~N,groups=sp.pair,data=rand.means,auto.key=T)

xyplot(X15N~decomp|treatment,data=pd)

#svg("bivar.svg",height=3.5)
pdf(file="../figures/bivar.pdf",height=3.5)
bivar.graph(Xvar="decomp",Yvar="survival",yvar.lab="detritivore mortality")
dev.off()


bivar.graph(Xvar="N",Yvar="growth")


rbind(names(pd),1:length(names(pd)))
pairs(pd[,c(5,6,7,8,9,14,18,19)])


xyplot(chiromids~treatment,data=pd)

library(vegan)
library(MASS)

surv.dist <- vegdist(pd[-22,c("Culicidae","Chironomidae","Tipulidae","Psychodidae","Scirtidae")])

surv.ord <- isoMDS(surv.dist)

stressplot(surv.ord,surv.dist)

ordiplot(surv.ord,type="t")

ord <- data.frame(eu=rownames(surv.ord$points),surv.ord$points)

test <- merge(ord,pd,all.y=TRUE)

combo.ord <-
  subset(test,test$treatment%in%c("elong + tab","elong + leech","elong + andro"))

svg("../figures/ord.svg")
par(bty="l",cex=1.5)
with(combo.ord,plot(X1,X2,type="n",xlab="axis 1",ylab="axis 2"))
with(subset(combo.ord,combo.ord$treatment=="elong + andro"),points(X1,X2,pch=21,bg="black"))
with(subset(combo.ord,combo.ord$treatment=="elong + tab"),points(X1,X2,pch=21,bg="white"))
with(subset(combo.ord,combo.ord$treatment=="elong + leech"),points(X1,X2,pch=21,bg="grey"))
dev.off()

xyplot(X2~X1,groups=treatment,data=subset(test,test$treatment%in%c("elong + tab","elong + leech","elong + andro")),pch=21,auto.key=TRUE)

xyplot(Culicidae+Chironomidae+Tipulidae+Psychodidae+Scirtidae~treatment,data=test)

par(mfrow=c(2,3))
lapply(c("Culicidae","Chironomidae","Tipulidae","Psychodidae","Scirtidae"),
       function(y) plot(test[,c("treatment",y)]))

##insect survivals

chiro.glm <- with(pd,glm(Chironomidae~treatment,family=poisson))
summary(chiro.glm)


