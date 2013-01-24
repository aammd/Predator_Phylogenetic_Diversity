lept<-read.csv("lept.csv")

with(lept,plot(Measuring..tail.~Measuring..body.,type='n'))
with(subset(lept,Sp.=="andromache"),points(Measuring..body.,Measuring..tail.,type=2))

library(lattice)

xyplot(Measuring..tail.~Measuring..body.*Sp.,data=lept)

xyplot(jitter(Measuring..tail.)~jitter(Measuring..body.),groups=Sp.,data=lept,auto.key=TRUE)

densityplot(~Measuring..body.|Sp.,data=lept)

lept.ae<-subset(lept,Sp.=="andromache"|Sp.=="elongatum")
lept.ae$sp<-factor(lept.ae$Sp.)

summary(with(lept.ae,lm(Measuring..tail.~Measuring..body.*sp)))
