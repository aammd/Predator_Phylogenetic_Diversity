

## determining the size of leeches et al to use

allo<-read.csv('allometry.csv')

## model of mass as a function of length for each animal
leech<-with(subset(allo,taxon=='leech'),lm(mass~length))
zygo<-with(subset(allo,taxon=='zygoptera'),lm(mass~length))
taban<-with(subset(allo,taxon=='Tabanid'),lm(mass~length))
taban.br<-with(subset(allo,taxon=='br.tabanid'),lm(mass~length))

## the equation for metabolic capacity is:
##         Metabolic = Mass^0.69

## so just replace Mass with the model for length. 
curve((coef(leech)[[2]]*x+coef(leech)[[1]])^0.69,ylim=c(0,0.7),xlim=c(0,35))

curve((coef(zygo)[[2]]*x+coef(zygo)[[1]])^0.69,add=TRUE,col='blue')

curve((coef(taban)[[2]]*x+coef(taban)[[1]])^0.69,add=TRUE,col='red')

#curve((coef(taban.br)[[2]]*x+coef(taban.br)[[1]])^0.69,add=TRUE,col='red',lwd=2)

## these graphs are basically metabolic capacity (y-axis) and total
## length of ONE individual (x-axis)

## So, what density of insects will give approximately similar
## metabolic capacity?
curve(2*((coef(zygo)[[2]]*x+coef(zygo)[[1]])^0.69),add=TRUE,col='blue',lty=2)

curve(5*((coef(leech)[[2]]*x+coef(leech)[[1]])^0.69),add=TRUE,lty=2)

## tried different densities, and found that 2 and 5 worked.  The
## curves look kind of the same.
## so one Tabanid = 2 damselflies = 5 leeches.

#with(allo,points(length,mass^0.69))

## what is the metabolic capacity for a resonable range of tabanid
## body lengths?
goal<-predict(taban,list(length=c(15,25)),type='response')

## OK, so the total metabolic capacity of the predators needs to be in
## this range:
abline(h=goal[[1]]^0.69)
abline(h=goal[[2]]^0.69)

#then just eyeball those lines back.  then, you get the total length
#of all the predators.  divide that total length by the densities, and
#you get the length of each.
predict(leech,list(length=100),type='response')^0.69

## 
