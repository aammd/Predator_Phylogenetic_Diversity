

pngPPT<-function(file,width=10,height=7.5,res=110,single=TRUE){
	png(file,width,height,units='in',res=res)
	if(single==TRUE)
	par(omi=c(0,1.25,0,1.25),bty='l')
	else
	par(bty='l')}	
