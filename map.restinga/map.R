data<-read.csv("map.restinga.utm.csv")
with(data,plot(east,north,type='n'))
with(data,text(east,north,labels=pt.name)
strange<-with(data,which(pt.name=='31'|pt.name=='30'|pt.name=='27'))


with(data[-strange,],plot(east,north,type='n'))

with(data[-strange,],text(east,north,labels=pt.name)

